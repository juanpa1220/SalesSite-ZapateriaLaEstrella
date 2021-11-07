import React, {Component} from 'react';
import styled from "styled-components";
import {ProductConsumer} from "../../context";
import DayPickerInput from 'react-day-picker/DayPickerInput';
import 'react-day-picker/lib/style.css';
import FadeTransition from "../../transitions/fadeTransition";
import Select from "react-select";

export default class LoginModal extends Component {

    constructor(props) {
        super(props);
        this.state = {
            isLoginOpen: true,
            isRegisterOpen: false
        };
    }

    showLoginBox() {
        this.setState({isLoginOpen: true, isRegisterOpen: false});
    }

    showRegisterBox() {
        this.setState({isRegisterOpen: true, isLoginOpen: false});
    }


    render() {
        return (
            <ProductConsumer>
                {value => {
                    const {loginModalOpen, closeLoginModal} = value;
                    if (!loginModalOpen) {
                        return null;
                    } else {
                        return (
                            <ProductConsumer>
                                {value => {
                                    return (
                                        <ModalContainer>
                                            <div className="container">
                                                <div className="row">
                                                    <div
                                                        className="col-8 mx-auto col-md-6 col-lg-4 p-5 text-center text-capitalize"
                                                        id="modal"
                                                    >

                                                        <div className="root-container">
                                                            <div className="box-controller">
                                                                <div
                                                                    className={"controller " + (this.state.isLoginOpen
                                                                        ? "selected-controller"
                                                                        : "")}
                                                                    onClick={this
                                                                        .showLoginBox
                                                                        .bind(this)}>
                                                                    Iniciar sesión
                                                                </div>
                                                                <div
                                                                    className={"controller " + (this.state.isRegisterOpen
                                                                        ? "selected-controller"
                                                                        : "")}
                                                                    onClick={this
                                                                        .showRegisterBox
                                                                        .bind(this)}>
                                                                    Registrarse
                                                                </div>
                                                            </div>

                                                            <FadeTransition isOpen={this.state.isLoginOpen}
                                                                            duration={0}>
                                                                <div className="box-container">
                                                                    <LoginBox value={value}/>
                                                                </div>
                                                            </FadeTransition>
                                                            <FadeTransition isOpen={this.state.isRegisterOpen}
                                                                            duration={0}>
                                                                <div className="box-container">
                                                                    <RegisterBox value={value}/>
                                                                </div>
                                                            </FadeTransition>

                                                            <button
                                                                type="button"
                                                                className="login-btn mr-auto ml-auto"
                                                                onClick={closeLoginModal}>
                                                                Salir
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ModalContainer>
                                    )
                                }}
                            </ProductConsumer>

                        );
                    }
                }}
            </ProductConsumer>
        );
    }
}

const ModalContainer = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  #modal {
    background: var(--mainWhite);
  }
`;

class LoginBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            username: "",
            password: "",
            error: false,
            loginPerson: [],
            errors: []
        };
    }

    onUsernameChange(e) {
        this.setState({username: e.target.value, error: false});
    }

    onPasswordChange(e) {
        this.setState({password: e.target.value, error: false});
    }

    render() {
        const {loginModalOpen, closeLoginModal, setLoginPerson} = this.props.value;
        if (!loginModalOpen) {
            return null;
        } else {
            return (
                <div className="inner-container">
                    <div className="header">
                        Inicio de Sesión
                    </div>
                    <div className="box">

                        <div className="input-group">
                            <label htmlFor="username">Nombre de usuario</label>
                            <input
                                type="text"
                                name="username"
                                className="login-input"
                                placeholder="Username"
                                onChange={this
                                    .onUsernameChange
                                    .bind(this)}/>
                        </div>

                        <div className="input-group">
                            <label htmlFor="password">Contraseña</label>
                            <input
                                type="password"
                                name="password"
                                className="login-input"
                                placeholder="Password"
                                onChange={this
                                    .onPasswordChange
                                    .bind(this)}/>
                        </div>

                        <small className="danger-error">{this.state.error
                            ? "Usuario o contraseña incorrecta"
                            : ""}</small>

                        <button
                            type="button"
                            className="login-btn"
                            onClick={
                                () => {
                                    fetch(`http://localhost:5000/login?username=${this.state.username}&password=${this.state.password}`)
                                        .then(res => res.json())
                                        .then((data) => {
                                            const response = data.recordsets[0][0].result
                                            if (this.state.loginPerson.length === 0 && Number(response) > 0) {
                                                closeLoginModal();
                                                setLoginPerson(response, this.state.username);
                                                this.setState({
                                                    loginPerson: {
                                                        idUser: Number(response),
                                                        username: this.state.username,
                                                        password: this.state.password
                                                    }
                                                })
                                            } else {
                                                this.setState({error: true});
                                            }
                                        })
                                        .catch(console.log);
                                }
                            }>
                            Iniciar sesión
                        </button>

                    </div>
                </div>
            );
        }
    }

}


class RegisterBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            name: "",
            lastname: "",
            birthDate: "",
            city: "",
            username: "",
            email: "",
            password: "",
            errors: [],
            pwdState: null,
            selectedCity: [{value: 'Direccion', label: 'Direccion'}]
        };
        this.handleCityChange = this.handleCityChange.bind(this);
    }

    showValidationErr(elm, msg) {
        this.setState((prevState) => ({
            errors: [
                ...prevState.errors, {
                    elm,
                    msg
                }
            ]
        }));
    }

    clearValidationErr(elm) {
        this.setState((prevState) => {
            let newArr = [];
            for (let err of prevState.errors) {
                if (elm !== err.elm) {
                    newArr.push(err);
                }
            }
            return {errors: newArr};
        });
    }

    onNameChange(e) {
        this.setState({name: e.target.value});
        this.clearValidationErr("name");
    }

    onLastnameChange(e) {
        this.setState({lastname: e.target.value});
        this.clearValidationErr("lastname");
    }

    onBirthDateChange = (date) => {
        this.setState({birthDate: `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`})
        this.clearValidationErr("birthDate");
    }

    onCityChange(city) {
        this.setState({city: city});
        this.clearValidationErr("city");
    }

    onUsernameChange(e) {
        this.setState({username: e.target.value});
        this.clearValidationErr("username");
    }

    onEmailChange(e) {
        this.setState({email: e.target.value});
        this.clearValidationErr("email");
    }

    onPasswordChange(e) {
        this.setState({password: e.target.value});
        this.clearValidationErr("password");

        this.setState({pwdState: "weak"});
        if (e.target.value.length > 8) {
            this.setState({pwdState: "medium"});
        }
        if (e.target.value.length > 12) {
            this.setState({pwdState: "strong"});
        }
    }

    openPopup(e) {
        console.log("Hello world!");
    }

    submitRegister() {
        let numErrors = 0;
        if (this.state.name === "") {
            this.showValidationErr("name", "Debe ingresar el nombre");
            numErrors += 1;
        }
        if (this.state.lastname === "") {
            this.showValidationErr("lastname", "Debe ingresar el apellido");
            numErrors += 1;
        }
        if (this.state.birthDate === "") {
            this.showValidationErr("birthDate", "Debe ingresar la fecha de nacimiento");
            numErrors += 1;
        }
        if (this.state.city === "") {
            this.showValidationErr("city", "Debe ingresar el cantón");
            numErrors += 1;
        }
        if (this.state.username === "") {
            this.showValidationErr("username", "Debe ingresar el nombre de usuario");
            numErrors += 1;
        }
        if (this.state.email === "") {
            this.showValidationErr("email", "Debe ingresar el correo");
            numErrors += 1;
        }
        if (this.state.password === "") {
            this.showValidationErr("password", "Debe ingresar la contraseña");
            numErrors += 1;
        }
        return numErrors;

    }

    handleCityChange(e) {
        this.setState({selectedCity: e});
        this.onCityChange(e.value)
    }

    render() {
        let nameErr = null,
            lastnameErr = null,
            birthDateErr = null,
            cityErr = null,
            usernameErr = null,
            passwordErr = null,
            emailErr = null;
        for (let err of this.state.errors) {
            if (err.elm === "name") {
                nameErr = err.msg;
            }
            if (err.elm === "lastname") {
                lastnameErr = err.msg;
            }
            if (err.elm === "birthDate") {
                birthDateErr = err.msg;
            }
            if (err.elm === "city") {
                cityErr = err.msg;
            }
            if (err.elm === "username") {
                usernameErr = err.msg;
            }
            if (err.elm === "password") {
                passwordErr = err.msg;
            }
            if (err.elm === "email") {
                emailErr = err.msg;
            }
        }
        let pwdWeak = false,
            pwdMedium = false,
            pwdStrong = false;
        if (this.state.pwdState === "weak") {
            pwdWeak = true;
        } else if (this.state.pwdState === "medium") {
            pwdWeak = true;
            pwdMedium = true;
        } else if (this.state.pwdState === "strong") {
            pwdWeak = true;
            pwdMedium = true;
            pwdStrong = true;
        }

        const {cities, loginModalOpen, closeLoginModal, setLoginPerson} = this.props.value;
        if (!loginModalOpen) {
            return null;
        } else {
            return (
                <div className="inner-container">
                    <div className="header">
                        Registrarse
                    </div>
                    <div className="box">
                        <div className="input-group">
                            <label htmlFor="name">Nombre</label>
                            <input
                                type="text"
                                name="name"
                                className="login-input"
                                placeholder="Name"
                                onChange={this
                                    .onNameChange
                                    .bind(this)}/>
                            <small className="danger-error">{nameErr
                                ? nameErr
                                : ""}</small>
                        </div>
                        <div className="input-group">
                            <label htmlFor="lastname">Apellido</label>
                            <input
                                type="text"
                                name="lastname"
                                className="login-input"
                                placeholder="Lastname"
                                onChange={this
                                    .onLastnameChange
                                    .bind(this)}/>
                            <small className="danger-error">{lastnameErr
                                ? lastnameErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="birthDate">Fecha de nacimiento</label>

                            <div className="date-input">
                                <DayPickerInput classNames="date-input" onDayChange={day =>
                                    this.onBirthDateChange(day)
                                }/>
                            </div>

                            <small className="danger-error">{birthDateErr
                                ? birthDateErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="city">Direccion</label>
                            <StyledSelect>
                                <div className="user-select">
                                    <div className="row">
                                        <div className="col col-sm-12">
                                            <Select
                                                placeholder="Select Option"
                                                value={this.state.selectedCity} // set selected value
                                                options={cities} // set list of the data
                                                onChange={this.handleCityChange} // assign onChange function
                                                theme={(theme) => ({
                                                    ...theme,
                                                    colors: {
                                                        ...theme.colors,
                                                        text: 'orangered',
                                                        primary25: 'neutral5',
                                                        primary: 'var(--lightBlue)',
                                                    },
                                                })}
                                            />
                                        </div>
                                    </div>
                                </div>
                            </StyledSelect>

                            <small className="danger-error">{cityErr
                                ? cityErr
                                : ""}</small>
                        </div>


                        <div className="input-group">
                            <label htmlFor="username">Nombre de Usuario</label>
                            <input
                                type="text"
                                name="username"
                                className="login-input"
                                placeholder="Username"
                                onChange={this
                                    .onUsernameChange
                                    .bind(this)}/>
                            <small className="danger-error">{usernameErr
                                ? usernameErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="email">Email</label>
                            <input
                                type="text"
                                name="email"
                                className="login-input"
                                placeholder="Email"
                                onChange={this
                                    .onEmailChange
                                    .bind(this)}/>
                            <small className="danger-error">{emailErr
                                ? emailErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="password">Contraseña</label>
                            <input
                                type="password"
                                name="password"
                                className="login-input"
                                placeholder="Password"
                                onChange={this
                                    .onPasswordChange
                                    .bind(this)}/>
                            <small className="danger-error">{passwordErr
                                ? passwordErr
                                : ""}</small>

                            {this.state.password && <div className="password-state">
                                <div
                                    className={"pwd pwd-weak " + (pwdWeak
                                        ? "show"
                                        : "")}/>
                                <div
                                    className={"pwd pwd-medium " + (pwdMedium
                                        ? "show"
                                        : "")}/>
                                <div
                                    className={"pwd pwd-strong " + (pwdStrong
                                        ? "show"
                                        : "")}/>
                            </div>}

                        </div>

                        <button
                            type="button"
                            className="login-btn"
                            onHover={this
                                .openPopup
                                .bind(this)}
                            onClick={
                                () => {
                                    let numErrors = this.submitRegister();
                                    if (numErrors === 0) {
                                        fetch(`http://localhost:5000/register?p_name=${this.state.name}&p_lastname=${this.state.lastname}&p_birthdate=${this.state.birthDate}&p_address=${this.state.city}&p_email=${this.state.email}&p_username=${this.state.username}&p_password=${this.state.password}`)
                                            .then(res => res.json())
                                            .then((data) => {
                                                const idUser = data.recordsets[0][0].result
                                                console.log('idUser: ' + idUser)
                                                closeLoginModal();
                                                setLoginPerson(Number(idUser), this.state.name);

                                            })
                                            .catch(console.log);
                                    }
                                }
                            }>Registrarse
                        </button>

                    </div>
                </div>
            );
        }
    }
}

const StyledSelect = styled.div`
    .user-select {
        border-radius: 5px;
        border: 1px solid var(--lightBlue);
        transition: border 0.4s ease-out;
        color: var(--mainWhiteWrapper);
        font-size: 1.2rem;
        color: #3e3e42;
        background: rgba(15, 15, 15, 0.01);
    }
    `;
import React, {Component} from 'react';
import styled from "styled-components";
import {ProductConsumer} from "../../context";
import DayPickerInput from 'react-day-picker/DayPickerInput';
import 'react-day-picker/lib/style.css';
import FadeTransition from "../../transitions/fadeTransition";
import Select from "react-select";

export default class SaleModel extends Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <ProductConsumer>
                {value => {
                    const {saleModalOpen, closeSaleModal} = value;
                    if (!saleModalOpen) {
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
                                                            <div className="box-container">
                                                                <RegisterSaleBox value={value}/>
                                                            </div>
                                                            <button
                                                                type="button"
                                                                className="login-btn mr-auto ml-auto"
                                                                onClick={closeSaleModal}>
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


class RegisterSaleBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            idProduct: 0,
            salePercentage: 0,
            expirationDate: '',
            description: " ",
            errors: [],
            selectedOption: {value: null, label: 'Sucursal'},
        };
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(e) {
        this.setState({
            selectedOption: e
        });
        this.clearValidationErr("subsidiary");
    };

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
        this.setState({idProduct: e.target.value});
        this.clearValidationErr("name");
    }

    onLastnameChange(e) {
        this.setState({salePercentage: e.target.value});
        this.clearValidationErr("lastname");
    }

    onBirthDateChange = (date) => {
        this.setState({expirationDate: `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`})
        this.clearValidationErr("birthDate");
    }

    onUsernameChange(e) {
        this.setState({description: e.target.value});
    }


    openPopup(e) {
        console.log("Hello world!");
    }

    submitRegister() {
        let numErrors = 0;
        if (this.state.idProduct === 0) {
            this.showValidationErr("name", "Debe ingresar el id del producto");
            numErrors += 1;
        }
        if (this.state.salePercentage === 0) {
            this.showValidationErr("lastname", "Debe ingresar el porcentaje de descuento");
            numErrors += 1;
        }
        if (this.state.expirationDate === "") {
            this.showValidationErr("birthDate", "Debe ingresar la fecha de expiración");
            numErrors += 1;
        }
        if (this.state.selectedOption.value === null) {
            this.showValidationErr("subsidiary", "Debe ingresar la sucursal");
            numErrors += 1;
        }
        return numErrors;

    }


    render() {
        let nameErr = null,
            lastnameErr = null,
            birthDateErr = null,
            usernameErr = null,
            subsidiaryErr = null;
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
            if (err.elm === "username") {
                usernameErr = err.msg;
            }
            if (err.elm === "subsidiary") {
                subsidiaryErr = err.msg;
            }
        }
        const {saleModalOpen, closeSaleModal} = this.props.value;
        if (!saleModalOpen) {
            return null;
        } else {
            return (
                <div className="inner-container">
                    <div className="header">
                        Registrar nueva promoción
                    </div>
                    <div className="box">

                        <div className="input-group">
                            <label htmlFor="name">Id del productos</label>

                            <Select
                                placeholder="Select Option"
                                value={this.state.selectedOption} // set selected value
                                options={[
                                    {
                                        value: 1,
                                        label: 'Sucursal Cartago'
                                    }, {
                                        value: 2,
                                        label: 'Sucursal San José'
                                    }, {
                                        value: 3,
                                        label: 'Sucursal Alajuela'
                                    }]} // set list of the data
                                onChange={this.handleChange} // assign onChange function
                                theme={(theme) => ({
                                    ...theme,
                                    colors: {
                                        ...theme.colors,
                                        text: 'orangered',
                                        primary25: 'silver',
                                        primary: 'var(--mainDark)',
                                    },
                                })}
                            />

                            <small className="danger-error">{subsidiaryErr
                                ? subsidiaryErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="name">Id del productos</label>
                            <input
                                type="text"
                                name="name"
                                className="login-input"
                                placeholder="Id Producto"
                                onChange={this
                                    .onNameChange
                                    .bind(this)}/>
                            <small className="danger-error">{nameErr
                                ? nameErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="lastname">Porcentaje de descuento</label>
                            <input
                                type="text"
                                name="lastname"
                                className="login-input"
                                placeholder="Porcentaje"
                                onChange={this
                                    .onLastnameChange
                                    .bind(this)}/>
                            <small className="danger-error">{lastnameErr
                                ? lastnameErr
                                : ""}</small>
                        </div>

                        <div className="input-group">
                            <label htmlFor="birthDate">Fecha de expiración</label>
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
                            <label htmlFor="username">Descripción</label>
                            <input
                                type="text"
                                name="username"
                                className="login-input"
                                placeholder="Descripción"
                                onChange={this
                                    .onUsernameChange
                                    .bind(this)}/>
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
                                        console.log(this.state.selectedOption.value);
                                        console.log(this.state.idProduct);
                                        console.log(this.state.salePercentage);
                                        console.log(this.state.expirationDate);
                                        console.log(this.state.description);
                                        let test = `http://localhost:5000/createsale?idSubsidiary=${this.state.selectedOption.value}&idProduct=${this.state.idProduct}&salePercentage=${this.state.salePercentage}&expirationDate=${this.state.expirationDate}&description=${this.state.description}`;
                                        console.log(test)
                                        fetch(test)
                                            .then(res => res.json())
                                            .then((data) => {
                                                    console.log(data)
                                                    closeSaleModal();
                                                }
                                            )
                                            .catch(console.log);
                                    }
                                }
                            }>Registrar
                        </button>

                    </div>
                </div>
            );
        }
    }
}

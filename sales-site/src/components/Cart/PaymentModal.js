import React, {Component} from 'react';
import styled from "styled-components";
import {ProductConsumer} from "../../context";
import DayPickerInput from 'react-day-picker/DayPickerInput';
import 'react-day-picker/lib/style.css';
import FadeTransition from "../../transitions/fadeTransition";
import Select from "react-select";

export default class PaymentModal extends Component {

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
                    const {paymentModalOpen, closePaymentModal} = value;
                    if (!paymentModalOpen) {
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
                                                        id="modal">


                                                        <div className="root-container">
                                                            {/*<div className="root-container">*/}
                                                            {/*    <div className="box-container">*/}
                                                            {/*        <PaymentBox value={value}/>*/}
                                                            {/*    </div>*/}
                                                            {/*</div>*/}
                                                            <div className="box-controller">
                                                                <div
                                                                    className={"controller " + (this.state.isLoginOpen
                                                                        ? "selected-controller"
                                                                        : "")}
                                                                    onClick={
                                                                        this
                                                                            .showLoginBox
                                                                            .bind(this)
                                                                    }>
                                                                    Delivery
                                                                </div>
                                                                <div
                                                                    className={"controller " + (this.state.isRegisterOpen
                                                                        ? "selected-controller"
                                                                        : "")}
                                                                    onClick={this
                                                                        .showRegisterBox
                                                                        .bind(this)}>
                                                                    Pickup
                                                                </div>
                                                            </div>

                                                            <FadeTransition isOpen={this.state.isLoginOpen}
                                                                            duration={0}>
                                                                <div className="box-container">
                                                                    <OnlinePaymentBox value={value}/>
                                                                </div>
                                                            </FadeTransition>
                                                            <FadeTransition isOpen={this.state.isRegisterOpen}
                                                                            duration={0}>
                                                                <div className="box-container">
                                                                    <SubsidiaryPaymentBox value={value}/>
                                                                </div>
                                                            </FadeTransition>

                                                            <button
                                                                type="button"
                                                                className="login-btn mr-auto ml-auto"
                                                                onClick={closePaymentModal}>
                                                                Cancelar
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

class SubsidiaryPaymentBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            confirmed: false,
            message: '',
        };
    }

    render() {
        const {paymentModalOpen, registerPurchase, getSubsidiary, clearCart, updateStock} = this.props.value;
        if (!paymentModalOpen) {
            return null;
        } else {
            return (
                <div className="inner-container">
                    <div className="header">
                        Pickup
                    </div>
                    <div className="box">
                        <button
                            type="button"
                            className="login-btn"
                            disabled={this.state.confirmed}
                            hidden={this.state.confirmed}
                            onClick={
                                () => {
                                    registerPurchase(false);
                                    this.setState({confirmed: true});
                                    updateStock();
                                }
                            }>
                            Confirmar Pedido
                        </button>
                        <small className="coupon-applied">{this.state.confirmed
                            ? 'Su pago se procesó en la sucursal ' + getSubsidiary()
                            : ""}</small>
                        <button
                            type="button"
                            className="login-btn"
                            disabled={!this.state.confirmed}
                            hidden={!this.state.confirmed}
                            onClick={
                                () => {
                                    clearCart();
                                }
                            }>
                            Aceptar
                        </button>
                    </div>
                </div>
            );
        }
    }

}


class OnlinePaymentBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            confirmed: false,
            message: '',
            error: true,
            errorMessage: ''
        };
    }

    onTarjetaChange(e) {
        if (e.target.value === '') {
            this.setState({error: true})
        } else {
            this.setState({error: false})
            this.setState({errorMessage: ''})
        }
    }

    render() {
        const {paymentModalOpen, registerPurchase, registerPayment, getSubsidiary, clearCart, setDelivery, updateStock} = this.props.value;
        if (!paymentModalOpen) {
            return null;
        } else {
            return (
                <div className="inner-container">
                    <div className="header">
                        Delivery
                    </div>
                    <div className="box">

                        <div className="input-group" hidden={this.state.confirmed}>
                            <label htmlFor="username">Número de tarjeta</label>
                            <input
                                type="text"
                                name="username"
                                className="login-input"
                                placeholder="Número tarjeta"
                                onChange={this
                                    .onTarjetaChange
                                    .bind(this)}
                            />
                        </div>
                        <div className="input-group" hidden={this.state.confirmed}>
                            <label htmlFor="username">Código de tarjeta</label>
                            <input
                                type="text"
                                name="username"
                                className="login-input"
                                placeholder="Código tarjeta"
                                onChange={this
                                    .onTarjetaChange
                                    .bind(this)}
                            />
                        </div>

                        <button
                            type="button"
                            className="login-btn"
                            disabled={this.state.confirmed}
                            hidden={this.state.confirmed}
                            onClick={
                                () => {
                                    if (!this.state.error) {
                                        registerPurchase(true);
                                        setDelivery(true);
                                        registerPayment();
                                        updateStock();
                                        this.setState({confirmed: true});
                                    } else {
                                        this.setState({errorMessage: 'Formulario incompleto'})
                                    }
                                }
                            }>
                            Confirmar Pago
                        </button>
                        <small className="coupon-applied">{this.state.confirmed
                            ? 'Su pago se procesó en la sucursal ' + getSubsidiary()
                            : ""}</small>
                        <small className="danger-error">{this.state.error
                            ? this.state.errorMessage
                            : ""}</small>

                        <button
                            type="button"
                            className="login-btn"
                            disabled={!this.state.confirmed}
                            hidden={!this.state.confirmed}
                            onClick={
                                () => {
                                    clearCart();
                                }
                            }>
                            Aceptar
                        </button>

                    </div>
                </div>
            );
        }
    }

}
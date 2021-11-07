import React, {Component} from "react";
// import PayPalButton from "./PayPalButton";
import {Link} from "react-router-dom";
import PaymentModal from "./PaymentModal";

export default class CartTotals extends Component {
    constructor(props) {
        super(props);
        this.state = {
            discountCoupon: '',
            couponApplied: '',
            couponFail: '',
            paymentFail: ''
        };
    }

    onCouponChange(e) {
        this.setState({discountCoupon: e.target.value, couponApplied: '', couponFail: ''});
    }

    render() {
        const {
            coupon,
            cartSubTotal,
            cartDiscount,
            cartTax,
            cartTotal,
            productsInCart,
            clearCart,
            loginPerson,
            isLoginPerson,
            getSPValidateCoupon,
            openPaymentModal

        } = this.props.value;
        const emptyCart = productsInCart.length === 0;
        return (
            <React.Fragment>
                {!emptyCart && (
                    <div className="container">
                        <div className="row">
                            <div className="col-10 mt-2 ml-sm-5 ml-md-auto col-sm-8 text-capitalize text-right">
                                <Link to="/">
                                    <button
                                        className="btn btn-outline-danger text-uppercase mb-3 px-5"
                                        type="button"
                                        onClick={() => {
                                            clearCart();
                                        }}
                                    >
                                        limpiar carrito
                                    </button>
                                </Link>

                                <h5>
                                    <input
                                        type="text"
                                        name="Código de descuento"
                                        className="coupon-input"
                                        placeholder="Código de descuento"
                                        onChange={
                                            this
                                                .onCouponChange
                                                .bind(this)
                                        }/>
                                </h5>
                                <button
                                    type="button"
                                    className="coupon-btn"
                                    onClick={
                                        () => {
                                            if (isLoginPerson) {
                                                getSPValidateCoupon(loginPerson.idUser, this.state.discountCoupon);
                                                if (coupon > 0) {
                                                    this.setState({couponApplied: 'Cupón Aplicado'});
                                                    this.setState({couponFail: ''});
                                                } else {
                                                    this.setState({couponFail: 'Cupón Inválido'});
                                                    this.setState({couponApplied: ''});
                                                }
                                            } else {
                                                this.setState({couponFail: 'Debe Iniciar Sesión'});
                                                this.setState({couponApplied: ''});
                                            }
                                        }
                                    }>Aplicar Código
                                </button>
                                <h5 className="coupon-applied">
                                    {this.state.couponApplied}
                                </h5>
                                <h5 className="coupon-fail">
                                    {this.state.couponFail}
                                </h5>
                                <h5>
                                    <span className="text-title"> subtotal :</span>{" "}
                                    <strong>$ {cartSubTotal} </strong>
                                </h5>
                                <h5>
                                    <span className="text-title"> descuento :</span>{" "}
                                    <strong>$ {cartDiscount} </strong>
                                </h5>
                                <h5>
                                    <span className="text-title"> impuesto :</span>{" "}
                                    <strong>$ {cartTax} </strong>
                                </h5>
                                <h5>
                                    <span className="text-title"> total :</span>{" "}
                                    <strong>$ {cartTotal} </strong>
                                </h5>

                                <button
                                    type="button"
                                    className="coupon-btn"
                                    onClick={
                                        () => {
                                            if (isLoginPerson) {
                                                openPaymentModal()
                                                this.setState({paymentFail: ''})
                                            } else {
                                                this.setState({paymentFail: 'Debe Iniciar Sesión'})
                                            }
                                        }
                                    }>Pagar
                                </button>
                                <h5 className="coupon-fail">
                                    {this.state.paymentFail}
                                </h5>
                                <PaymentModal/>
                            </div>
                        </div>
                    </div>
                )}
            </React.Fragment>
        );
    }
}

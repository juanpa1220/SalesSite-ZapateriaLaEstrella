import React, {Component} from "react";
import CartItem from "./CartItem";

export default class CartList extends Component {
    render() {
        const {value} = this.props;
        const {productsInCart} = this.props.value;
        return (
            <div className="container-fluid">
                {
                    productsInCart.map(product => (
                        <CartItem key={product.idProduct} item={product} value={value}/>
                    ))
                }
            </div>
        );
    }
}
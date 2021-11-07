import React, {Component} from 'react';
import {ProductConsumer} from "../context";
import {ButtonContainer} from "./Button";
import {Link} from "react-router-dom";

class Details extends Component {
    render() {
        return (
            <ProductConsumer>
                {value => {
                    const {idProduct = 1, photo, description, finalCost, name} = value.detailProduct;
                    let condition = value.isProductInCart(idProduct) || !value.isLoginPerson || !value.isProductInStock(idProduct, 1);
                    return (
                        <div className="container py-5">
                            {/* title */}
                            <div className="row">
                                <div className="col-10 mx-auto text-center text-slanted text-blue my-5">
                                    <h1>{name}</h1>
                                </div>
                            </div>
                            {/* end of title */}
                            <div className="row">
                                <div className="col-10 mx-auto col-md-6 my-3">
                                    <img src={photo} className="img-fluid" alt=""/>
                                </div>
                                {/* prdoduct info */}
                                <div className="col-10 mx-auto col-md-6 my-3 text-capitalize">
                                    <h1>Modelo : {name}</h1>
                                    <h4 className="text-blue">
                                        <strong>
                                            Precio : <span>$</span>
                                            {finalCost}
                                        </strong>
                                    </h4>
                                    <h4 className="text-bright" hidden={!value.isLoginPerson}>
                                        <strong>
                                            {value.getProductStock(idProduct)} en stock
                                        </strong>
                                    </h4>

                                    {value.isLoginPerson && value.getProductSale(idProduct) > 0?
                                        (<h4 className="text-bright">
                                            <strong>
                                                -{value.getProductSale(idProduct)}% de descuento!!!
                                            </strong>
                                        </h4>) :
                                        (<h4 className="text-bright">
                                        </h4>)}
                                    <p className="text-capitalize font-weight-bold mt-3 mb-0">
                                        Alguna información del producto:
                                    </p>

                                    <p className="text-muted lead">{description}</p>
                                    {/* buttons */}
                                    <div>
                                        <Link to="/">
                                            <ButtonContainer>Regresar</ButtonContainer>
                                        </Link>
                                        <ButtonContainer
                                            cart
                                            disabled={condition}
                                            onClick={() => {
                                                value.addProductInCart(idProduct);
                                                // value.addToCart(idProduct);
                                                value.openModal(idProduct);
                                            }}
                                        >
                                            {value.isProductInCart(idProduct) ? (
                                                <p className="text-capitalize mb-0" disabled>
                                                    En el carrito
                                                </p>
                                            ) : (
                                                value.isLoginPerson ?
                                                    (value.getProductStock(idProduct) === 0 ?
                                                        (<i className="fas">No hay stock</i>) :
                                                        (<i className="fas fa-cart-plus"/>)) :
                                                    (<i className="fas">Debe iniciar sesión</i>)
                                            )}
                                        </ButtonContainer>
                                    </div>
                                </div>
                            </div>
                        </div>
                    );
                }}
            </ProductConsumer>
        );
    }
}

export default Details;
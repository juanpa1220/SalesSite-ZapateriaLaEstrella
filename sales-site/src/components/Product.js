import React, {Component} from 'react';
import styled from "styled-components";
import {Link} from "react-router-dom";
import {ProductConsumer} from "../context";

class Product extends Component {
    render() {
        const {idProduct, name, photo, finalCost} = this.props.product;
        return (
            <ProductWrapper className="col-9 mx-auto col-md-6 col-lg-3 my-3">
                <div className="card">
                    <ProductConsumer>
                        {value => {
                            let condition = value.isProductInCart(idProduct) || !value.isLoginPerson || !value.isProductInStock(idProduct, 1);
                            return (

                                <div
                                    className="img-container p-5"
                                    onClick={() => value.handleDetail(idProduct)}
                                >
                                    <p
                                        hidden={!value.isLoginPerson}
                                        className="stock text-center">
                                        {value.getProductStock(idProduct)} en stock
                                    </p>

                                    <Link to="/details">
                                        <img src={photo} alt="" className="card-img-top"/>
                                    </Link>
                                    <button
                                        className="cart-btn"
                                        disabled={condition}
                                        onClick={() => {
                                            value.addProductInCart(idProduct)
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
                                    </button>
                                    {value.isLoginPerson && value.getProductSale(idProduct) > 0 ?
                                        (<p
                                            // hidden={!value.getProductSale(idProduct) > 0}
                                            className="sale">
                                            {
                                                (!value.getProductSale(idProduct) > 0)
                                            }
                                            -{value.getProductSale(idProduct)}% de descuento!!!
                                        </p>) :
                                        (<p
                                            // hidden={!value.getProductSale(idProduct) > 0}
                                            className="sale">
                                        </p>)}

                                </div>

                            );
                        }}
                    </ProductConsumer>
                    <div className="card-footer d-flex justify-content-between">
                        <p className="align-self-center mb-0">{name}</p>
                        <h5 className="text-blue font-italic mb-0">
                            <span className="mr-1">$</span>
                            {finalCost}
                        </h5>
                    </div>
                </div>
            </ProductWrapper>
        );
    }
}

export default Product;

const ProductWrapper = styled.div`
  .card {
    border-color: transparent;
    transition: all 0.5s linear;
  }
  .card-footer {
    background: transparent;
    border-top: transparent;
    transition: all 0.5s linear;
  }
  .stock {
    color: var(--lightBlue);
    position: relative;
  }
  .sale {
    color: var(--mainYellow);
    bottom: 25px;
    position: absolute;
  }
  &:hover {
    .card {
      border: 0.04rem solid rgba(0, 0, 0, 0.2);
      box-shadow: 2px 2px 5px 0px rgba(0, 0, 0, 0.2);
    }
    .card-footer {
      background: rgba(247, 247, 247);
    }
  }
  .img-container {
    position: relative;
    overflow: hidden;
  }
  .card-img-top {
    transition: all 0.5s linear;
  }
  .img-container:hover .card-img-top {
    transform: scale(1.2);
  }
  .cart-btn {
    position: absolute;
    bottom: 0;
    right: 0;
    padding: 0.2rem 0.4rem;
    background: var(--lightBlue);
    border: none;
    color: var(--mainWhite);
    font-size: 1.4rem;
    border-radius: 0.5rem 0 0 0;
    transform: translate(100%, 100%);
    transition: all 0.5s ease-in-out;
  }
  .img-container:hover .cart-btn {
    transform: translate(0, 0);
  }
  .cart-btn:hover {
    color: var(--mainBlue);
    cursor: pointer;
  }
`;


import React, {Component} from "react";

export default class CartColumns extends Component {
    render() {
        return (
            <div className="container-fluid text-center d-none d-lg-block my-5">
                <div className="row ">
                    <div className="col-10 mx-auto col-lg-2">
                        <p className="text-uppercase"><strong>Productos</strong></p>
                    </div>
                    <div className="col-10 mx-auto col-lg-2">
                        <p className="text-uppercase"><strong>Nombre Producto</strong></p>
                    </div>
                    <div className="col-10 mx-auto col-lg-2">
                        <p className="text-uppercase"><strong>Precio</strong></p>
                    </div>
                    <div className="col-10 mx-auto col-lg-2">
                        <p className="text-uppercase"><strong>Cantidad</strong></p>
                    </div>
                    <div className="col-10 mx-auto col-lg-2">
                        <p className="text-uppercase"><strong>Remover</strong></p>
                    </div>
                    <div className="col-10 mx-auto col-lg-2">
                        <p className="text-uppercase"><strong>Total</strong></p>
                    </div>
                </div>
            </div>
        );
    }
}
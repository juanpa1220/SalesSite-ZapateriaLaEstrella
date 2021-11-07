import React from "react";
import Title from "../Title";

export default function EmptyCart() {
    return (
        <div className="container mt-5">
            <div className="row">
                <div className="col-10 mx-auto text-center text-title text-capitalize">
                    <Title name="Su Carrito" title="Está Vacío" />
                    {/*<h1>Su Carrito Está Vacío</h1>*/}
                </div>
            </div>
        </div>
    );
}
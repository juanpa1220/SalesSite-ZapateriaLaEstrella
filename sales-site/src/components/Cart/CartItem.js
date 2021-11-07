import React, {Component} from "react";

export default class CartItem extends Component {
    render() {
        const {idProduct, count} = this.props.item;
        const {increment, decrement, removeItem, getItem, isProductInStock} = this.props.value;
        const item = getItem(idProduct)

        return (
            <div className="row my-1 text-capitalize text-center">
                <div className="col-10 mx-auto col-lg-2">
                    <img
                        src={item.photo}
                        style={{width: "5rem", heigth: "5rem", border: "0.04rem solid rgba(0, 0, 0, 0.2)"}}
                        className="img-fluid"
                        alt=""
                    />
                </div>
                <div className="col-10 mx-auto col-lg-2 mt-auto mb-auto">
                    <span className="d-lg-none">Producto:</span> {item.name}
                </div>
                <div className="col-10 mx-auto col-lg-2 mt-auto mb-auto">
                    <strong>
                        <span className="d-lg-none">Precio:</span> ${item.finalCost}
                    </strong>
                </div>
                <div className="col-10 mx-auto col-lg-2 my-2 my-lg-0">
                    <div className="d-flex justify-content-center">
                        <div>
                          <span className="btn btn-black mx-1 my-5" onClick={() => {
                              return decrement(idProduct);
                          }}>
                            -
                          </span>
                            <span className="btn btn-black mx-1 my-5">{count}</span>
                            <span className="btn btn-black mx-1 my-5"
                                  hidden={!isProductInStock(idProduct, count + 1)}
                                  onClick={() => {
                                      return increment(idProduct);
                                  }}>
                            +
                          </span>
                        </div>
                    </div>
                </div>
                <div className="col-10 mx-auto col-lg-2 mx-1 mt-auto mb-auto">
                    <div className=" cart-icon" onClick={() => removeItem(idProduct)}>
                        <i className="fas fa-trash"/>
                    </div>
                </div>

                <div className="col-10 mx-auto col-lg-2 mt-auto mb-auto">
                    <strong><span className="d-lg-none">Total:</span> ${count * item.finalCost} </strong>
                </div>
            </div>
        );
    }
}

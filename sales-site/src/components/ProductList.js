import React, {Component} from 'react';
import Product from "./Product";
import Title from "./Title";
import {ProductConsumer} from "../context";
import Select from 'react-select';
import styled from "styled-components";

class ProductList extends Component {
    constructor(props) {
        super(props);
        this.state = {
            selectedOption: {value: 0, label: 'Categorías'},
        }
        this.handleChange = this.handleChange.bind(this);
    }

    handleChange(e) {
        this.setState({
            selectedOption: e
        });
    }

    render() {
        return (
            <React.Fragment>
                <div className="py-5">
                    <div className="container">
                        <Title name="Nuestros" title="Productos"/>
                        <ProductConsumer>
                            {value => {
                                return <StyledSelect>
                                    <div className="user-select">
                                        <div className="row">
                                            <div className="col col-sm-12 col-md-3">
                                                <Select
                                                    placeholder="Select Option"
                                                    value={this.state.selectedOption} // set selected value
                                                    options={value.categorias} // set list of the data
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
                                            </div>
                                        </div>
                                        <div className="description">
                                            <p className="align-self-center mb-0">
                                                {value.categorias.filter(category => category.value === this.state.selectedOption.value).map(category => {
                                                    return category.description
                                                })}
                                            </p>
                                        </div>
                                    </div>
                                </StyledSelect>
                            }}
                        </ProductConsumer>
                        <div className="row">
                            <ProductConsumer>
                                {value => {
                                    if (this.state.selectedOption.value === 0) {
                                        return value.productos.map(product => {
                                            return <Product key={product.idProduct}
                                                            product={product}/>
                                        })
                                    }
                                    return value.productos.filter(product => product.idCategory === this.state.selectedOption.value).map(product => {
                                        return <Product key={product.idProduct}
                                                        product={product}/>
                                    })
                                }}
                            </ProductConsumer>
                        </div>
                    </div>
                </div>
            </React.Fragment>
        );
    }
}

export default ProductList;

const StyledSelect = styled.div`
    .user-select {
        padding: 0.2rem 0.4rem;
        border: none;
        color: var(--mainWhiteWrapper);
        font-size: 1.2rem;
    }
    .description{
        padding: 0.9rem 0.1rem;
        color: var(----mainWhiteWrapper) !important;
        font-size: 1.5rem !important;
    }
    `;



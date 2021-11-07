import React, {Component} from "react";
import Title from "../Title";
import {ProductConsumer} from "../../context";
import Select from "react-select";
import styled from "styled-components";
import DayPicker, {DateUtils} from 'react-day-picker';
import 'react-day-picker/lib/style.css';
import {ButtonContainer} from "../Button";
import MaterialTable from "material-table";

export default class Store extends Component {
    constructor(props) {
        super(props);
        this.state = {
            selectedOption: {value: null, label: 'Todas las Sucursales'},
            selectedProduct: {value: null, label: 'Todos los Productos'},
            selectedEmployee: {value: null, label: 'Todos los Empleados'},
            from: undefined,
            to: undefined,
            gainReport: [],
            salesReport: [],
            employeesInfo: [],
            productsInfo: [],
            productsColumn: []
        }
        this.handleChange = this.handleChange.bind(this);
        this.handleProductChange = this.handleProductChange.bind(this);
        this.handleEmployeeChange = this.handleEmployeeChange.bind(this);
        this.handleDayClick = this.handleDayClick.bind(this);
        this.handleResetClick = this.handleResetClick.bind(this);
    }

    handleChange(e) {
        this.setState({
            selectedOption: e
        });
    };

    handleProductChange(e) {
        this.setState({
            selectedProduct: e
        });
    };

    handleEmployeeChange(e) {
        this.setState({
            selectedEmployee: e
        });
    };

    getDate = () => {
        if (this.state.from !== undefined && this.state.to !== undefined) {
            const temFrom = `${this.state.from.getFullYear()}-${this.state.from.getMonth() + 1}-${this.state.from.getDate()}`;
            const temTo = `${this.state.to.getFullYear()}-${this.state.to.getMonth() + 1}-${this.state.to.getDate()}`;
            return {from: temFrom, to: temTo}
        }
        return {from: null, to: null}
    }

    handleDayClick(day) {
        const range = DateUtils.addDayToRange(day, this.state);
        this.setState({
            from: range.from,
            to: range.to
        });
    }

    handleResetClick() {
        this.setState({
            selectedOption: {value: null, label: 'Todas las Sucursales'},
            selectedProduct: {value: null, label: 'Todos los Productos'},
            selectedEmployee: {value: null, label: 'Todos los Empleados'},
            from: undefined,
            to: undefined,
            gainReport: [],
            salesReport: [],
            employeesInfo: [],
            productsInfo: []
        })
    }

    render() {
        const {from, to} = this.state;
        const modifiers = {start: from, end: to};
        return (
            <section>
                <ProductConsumer>
                    {value => {
                        const {isAdmin, ProductsSelect, employees, openSaleModal} = value;
                        if (isAdmin) {
                            return (
                                <React.Fragment>
                                    <div className="py-5">
                                        <div className="container">
                                            <Title title="Reportes"/>
                                            <ProductConsumer>
                                                {value => {
                                                    return <StyledSelect>
                                                        <div className="user-select mt-4">
                                                            <div className="row">
                                                                <div className='col col-sm-auto'>
                                                                    <DayPicker
                                                                        className="Selectable"
                                                                        numberOfMonths={this.props.numberOfMonths}
                                                                        selectedDays={[from, {from, to}]}
                                                                        modifiers={modifiers}
                                                                        onDayClick={this.handleDayClick}
                                                                    />
                                                                </div>

                                                                <div className="col">
                                                                    <div className="row mt-3 text-center mr-2">
                                                                        <div className="col text-left">
                                                                            <Select
                                                                                placeholder="Select Option"
                                                                                value={this.state.selectedOption} // set selected value
                                                                                options={[
                                                                                    {
                                                                                        value: null,
                                                                                        label: 'Todas las Sucursales'
                                                                                    }, {
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
                                                                        </div>

                                                                        <div className="col text-left">
                                                                            <Select
                                                                                placeholder="Select Option"
                                                                                value={this.state.selectedProduct} // set selected value
                                                                                options={ProductsSelect} // set list of the data
                                                                                onChange={this.handleProductChange} // assign onChange function
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
                                                                        <div className="col text-left">
                                                                            <Select
                                                                                placeholder="Select Option"
                                                                                value={this.state.selectedEmployee} // set selected value
                                                                                options={employees} // set list of the data
                                                                                onChange={this.handleEmployeeChange} // assign onChange function
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

                                                                    <div className="row mt-5 text-center mr-2">
                                                                        <div className="col">
                                                                            <ButtonContainer
                                                                                onClick={() => {
                                                                                    let test;
                                                                                    if (this.getDate().from !== null && this.getDate().to !== null) {
                                                                                        test = `http://localhost:5000/gainReport?idsubsidiary=${this.state.selectedOption.value}&idproduct=${this.state.selectedProduct.value}&from='${this.getDate().from}'&to='${this.getDate().to}'`;
                                                                                    } else {
                                                                                        test = `http://localhost:5000/gainReport?idsubsidiary=${this.state.selectedOption.value}&idproduct=${this.state.selectedProduct.value}&from=${null}&to=${null}`;
                                                                                    }
                                                                                    fetch(test)
                                                                                        .then(res => res.json())
                                                                                        .then((data) => {
                                                                                            this.setState({gainReport: data.recordsets[0]})
                                                                                        })
                                                                                        .catch(console.log);
                                                                                }
                                                                                }>
                                                                                Reporte Ganancias
                                                                            </ButtonContainer>
                                                                        </div>
                                                                        <div className="col">
                                                                            <ButtonContainer
                                                                                onClick={() => {
                                                                                    let test;
                                                                                    if (this.getDate().from !== null && this.getDate().to !== null) {
                                                                                        test = `http://localhost:5000/salesReport?idsubsidiary=${this.state.selectedOption.value}&idproduct=${this.state.selectedProduct.value}&idemployee=${this.state.selectedEmployee.value}&from='${this.getDate().from}'&to='${this.getDate().to}'`;
                                                                                    } else {
                                                                                        test = `http://localhost:5000/salesReport?idsubsidiary=${this.state.selectedOption.value}&idproduct=${this.state.selectedProduct.value}&idemployee=${this.state.selectedEmployee.value}&from=${null}&to=${null}`;
                                                                                    }
                                                                                    fetch(test)
                                                                                        .then(res => res.json())
                                                                                        .then((data) => {
                                                                                            this.setState({salesReport: data.recordsets[0]})
                                                                                        })
                                                                                        .catch(console.log);
                                                                                }
                                                                                }>
                                                                                Reporte Ventas
                                                                            </ButtonContainer>
                                                                        </div>
                                                                        <div className="col">
                                                                            <ButtonContainer
                                                                                onClick={() => {
                                                                                    this.handleResetClick()
                                                                                }
                                                                                }>
                                                                                Reiniciar valores
                                                                            </ButtonContainer>
                                                                        </div>
                                                                    </div>
                                                                    <div className="row mt-5 text-center mr-2">
                                                                        <div className="col">
                                                                            <ButtonContainer
                                                                                onClick={() => {
                                                                                    fetch(`http://localhost:5000/reademployees?idSubsidiary=${this.state.selectedOption.value}`)
                                                                                        .then(res => res.json())
                                                                                        .then((data) => {
                                                                                            this.setState({employeesInfo: data.recordsets[0]})
                                                                                        })
                                                                                        .catch(console.log);
                                                                                }
                                                                                }>
                                                                                Mostrar Empleados
                                                                            </ButtonContainer>
                                                                        </div>
                                                                        <div className="col">
                                                                            <ButtonContainer
                                                                                onClick={() => {
                                                                                    fetch(`http://localhost:5000/getproducts?idSubsidiary=${this.state.selectedOption.value}`)
                                                                                        .then(res => res.json())
                                                                                        .then((data) => {
                                                                                            this.setState({productsInfo: data.recordsets[0]});
                                                                                            if (this.state.selectedOption.value === null) {
                                                                                                this.setState({
                                                                                                    productsColumn: [{
                                                                                                        title: 'Sucursal',
                                                                                                        field: 'Sucursal'
                                                                                                    }, {
                                                                                                        title: 'Nombre',
                                                                                                        field: 'Nombre'
                                                                                                    }, {
                                                                                                        title: 'Precio',
                                                                                                        field: 'Precio'
                                                                                                    }]
                                                                                                })
                                                                                            } else {
                                                                                                this.setState({
                                                                                                    productsColumn: [{
                                                                                                        title: 'Nombre',
                                                                                                        field: 'Nombre'
                                                                                                    }, {
                                                                                                        title: 'Pecio',
                                                                                                        field: 'Pecio'
                                                                                                    }, {
                                                                                                        title: 'Descuento',
                                                                                                        field: 'Descuento'
                                                                                                    }]
                                                                                                })
                                                                                            }
                                                                                        })
                                                                                        .catch(console.log);
                                                                                }
                                                                                }>
                                                                                Mostrar Productos
                                                                            </ButtonContainer>
                                                                        </div>
                                                                        <div className="col">
                                                                            <ButtonContainer
                                                                                onClick={() => {
                                                                                    openSaleModal();
                                                                                    // fetch(`http://localhost:5000/reademployees?idSubsidiary=${this.state.selectedOption.value}`)
                                                                                    //     .then(res => res.json())
                                                                                    //     .then((data) => {
                                                                                    //         this.setState({employeesInfo: data.recordsets[0]})
                                                                                    //     })
                                                                                    //     .catch(console.log);
                                                                                }
                                                                                }>
                                                                                Crear Descuento
                                                                            </ButtonContainer>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div className="row">

                                                            </div>
                                                        </div>
                                                        <div className="mt-4"
                                                             hidden={this.state.gainReport.length === 0}>
                                                            <MaterialTable
                                                                title="Reporte de Ganancias"
                                                                data={this.state.gainReport}
                                                                isLoading={
                                                                    this.state.gainReport.length === 0
                                                                }
                                                                columns={[{
                                                                    title: 'Sucursal',
                                                                    field: 'Sucursal'
                                                                }, {
                                                                    title: '#Producto',
                                                                    field: '#Producto'
                                                                }, {
                                                                    title: 'Producto',
                                                                    field: 'Producto'
                                                                }, {
                                                                    title: 'Cantidad',
                                                                    field: 'Cantidad'
                                                                }, {
                                                                    title: 'Total',
                                                                    field: 'Total'
                                                                }
                                                                ]}
                                                                options={{
                                                                    search: true,
                                                                    filtering: true,
                                                                    exportButton: true
                                                                }}
                                                            />
                                                        </div>
                                                        <div className="mt-4"
                                                             hidden={this.state.salesReport.length === 0}>
                                                            <MaterialTable
                                                                title="Reporte de Ventas"
                                                                data={this.state.salesReport}
                                                                isLoading={
                                                                    this.state.salesReport.length === 0
                                                                }
                                                                columns={[{
                                                                    title: 'Sucursal',
                                                                    field: 'Sucursal'
                                                                }, {
                                                                    title: '#Empleado',
                                                                    field: '#Empleado'
                                                                }, {
                                                                    title: 'Empleado',
                                                                    field: 'Empleado'
                                                                }, {
                                                                    title: '#Producto',
                                                                    field: '#Producto'
                                                                }, {
                                                                    title: 'Producto',
                                                                    field: 'Producto'
                                                                }, {
                                                                    title: 'Cantidad',
                                                                    field: 'Cantidad'
                                                                }, {
                                                                    title: 'Total',
                                                                    field: 'Total'
                                                                }
                                                                ]}
                                                                options={{
                                                                    search: true,
                                                                    filtering: true,
                                                                    exportButton: true
                                                                }}

                                                            />
                                                        </div>
                                                        <div className="mt-4"
                                                             hidden={this.state.employeesInfo.length === 0}>
                                                            <MaterialTable
                                                                title="Empleados"
                                                                data={this.state.employeesInfo}
                                                                isLoading={
                                                                    this.state.employeesInfo.length === 0
                                                                }
                                                                columns={[{
                                                                    title: 'Nombre',
                                                                    field: 'Nombre'
                                                                }, {
                                                                    title: 'Apellido',
                                                                    field: 'Apellido'
                                                                }, {
                                                                    title: 'Puesto',
                                                                    field: 'Puesto'
                                                                }, {
                                                                    title: 'Salario base',
                                                                    field: 'Salario base'
                                                                }]}
                                                                options={{
                                                                    search: true,
                                                                    filtering: true,
                                                                    exportButton: true
                                                                }}
                                                            />
                                                        </div>
                                                        <div className="mt-4"
                                                             hidden={this.state.productsInfo.length === 0}>
                                                            <MaterialTable
                                                                title="Productos"
                                                                data={this.state.productsInfo}
                                                                isLoading={
                                                                    this.state.productsInfo.length === 0
                                                                }
                                                                columns={this.state.productsColumn}
                                                                options={{
                                                                    search: true,
                                                                    filtering: true,
                                                                    exportButton: true,
                                                                }}
                                                            />
                                                        </div>
                                                    </StyledSelect>
                                                }}
                                            </ProductConsumer>
                                        </div>
                                    </div>
                                </React.Fragment>
                            );
                        } else {
                            return (
                                <React.Fragment>
                                    <Title title="Su usuario no tiene permisos para esta ventana"/>
                                </React.Fragment>
                            );
                        }
                    }}
                </ProductConsumer>
            </section>
        );
    }
}

const StyledSelect = styled.div`
    .user-select {
        border-radius: 5px;
        border: 1px solid var(--lightBlue);
        transition: border 0.4s ease-out;
        color: var(--mainWhiteWrapper);
        font-size: 1.2rem;
        color: #3e3e42;
        background: rgba(15, 15, 15, 0.01);
    }
    `;
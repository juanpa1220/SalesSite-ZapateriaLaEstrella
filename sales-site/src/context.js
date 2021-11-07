import React, {Component} from 'react';

const ProductContext = React.createContext();
//Provider
//Context

class ProductProvider extends Component {
    state = {
        productos: [],
        ProductsSelect: [],
        productsInCart: [],
        detailProduct: [],
        categorias: [],
        employees: [],
        cities: [],
        stock: [],
        modalOpen: false,
        modalProduct: [],
        loginModalOpen: false,
        paymentModalOpen: false,
        scoreModalOpen: false,
        saleModalOpen: false,
        loginPerson: [], // {idUser: "1", username: "Juan"}
        isLoginPerson: false,
        isAdmin: false,
        isDelivery: false,
        idSubsidiary: 0,
        coupon: 0,
        cartSubTotal: 0,
        cartDiscount: 0,
        cartTax: 0,
        cartTotal: 0
    };

    componentDidMount() {
        this.getProductos();
        this.getCategorias();
        this.getCities();
        this.getEmplooyees();

        // test
        // this.setLoginPerson(4, 'jbrenes');
        // this.setLoginPerson(1, 'admin');
        // this.getStock(12);
        // console.log(this.isProductInStock(1, 1));
    };

    getProductos = () => {
        fetch('http://localhost:5000/products')
            .then(res => res.json())
            .then((data) => {
                const temProducts = data.recordsets[0]
                this.setState({productos: temProducts});
                this.setState({detailProduct: this.state.productos[0], modalProduct: this.state.productos[0]});
                const temProductsSelect = []
                temProductsSelect.push({value: null, label: 'Todos los productos'});
                for (const i in temProducts) {
                    temProductsSelect.push({value: Number(temProducts[i].idProduct), label: temProducts[i].name});
                }
                this.setState({ProductsSelect: temProductsSelect});
            })
            .catch(console.log);
    };

    getSPValidateCoupon = (idUser, coupon) => {
        fetch(`http://localhost:5000/coupon?idUser=${idUser}&coupon=${coupon}`)
            .then(res => res.json())
            .then((data) => {
                this.setState({coupon: Number(data.recordsets[0][0].result)});
                this.addTotals();
            })
            .catch(console.log);
    };

    getSPisAdmin = (idUser) => {
        fetch(`http://localhost:5000/isAdmin?idUser=${idUser}`)
            .then(res => res.json())
            .then((data) => {
                if (Number(data.recordsets[0][0].result) === 1) {
                    this.setState({isAdmin: true});
                } else {
                    this.setState({isAdmin: false});
                }
            })
            .catch(console.log);
    };

    getStock = (user) => {
        fetch(`http://localhost:5000/getstock?user=${user}`)
            .then(res => res.json())
            .then((data) => {
                this.setState({stock: data.recordsets[0]});
            })
            .catch(console.log);
    };

    updateStock = () => {
        this.getStock(Number(this.state.loginPerson.idUser));
    };

    getEmplooyees = () => {
        fetch(`http://localhost:5000/employees`)
            .then(res => res.json())
            .then((data) => {
                const temEmployees = data.recordsets[0];
                const temEmployeesSelected = []
                temEmployeesSelected.push({value: null, label: 'Todos los empleados'});
                for (const i in temEmployees) {
                    temEmployeesSelected.push({value: Number(temEmployees[i].value), label: temEmployees[i].label});
                }
                this.setState({employees: temEmployeesSelected});
            })
            .catch(console.log);
    };

    registerPurchase = (delivery) => {
        let products = this.state.productsInCart;
        let temProducts = '';
        for (const i in products) {
            temProducts += `${Number(products[i].idProduct)}:${products[i].count}_`
        }
        temProducts = temProducts.slice(0, -1);
        fetch(`http://localhost:5000/purchase?user=${this.state.loginPerson.idUser}&products=${temProducts}&coupon=${this.state.coupon}&delivery=${delivery}`)
            .then(res => res.json())
            .then((data) => {
                let temIdSubsidiary = data.recordsets[0][0].idSubsidiary;
                this.setState({idSubsidiary: temIdSubsidiary});
                this.registerPayment(temIdSubsidiary);
            })
            .catch(console.log);
    };

    registerPayment = (idSubsidiary) => {
        fetch(`http://localhost:5000/payment?&amount=${this.state.cartTotal}&idPaymentMethod=${1}&idSubsidiary=${idSubsidiary}`)
            .then(res => res.json())
            .then((data) => {
                console.log('payment registered: ' + data)
            })
            .catch(console.log);
    };

    registerScore = (comment, value) => {
        fetch(`http://localhost:5000/score?&idsubsidiary=${this.state.idSubsidiary}&comment=${comment}&value=${value}`)
            .then(res => res.json())
            .then((data) => {
                console.log('score registered: ' + data)
            })
            .catch(console.log);
    };

    setLoginPerson = (idUser, username) => {
        this.setState({loginPerson: {idUser: idUser, username: username}, isLoginPerson: true});
        this.getSPisAdmin(idUser);
        this.getStock(idUser);
    };

    setDelivery = (value) => {
        this.setState({isDelivery: value});
    };

    getCategorias = () => {
        fetch('http://localhost:5000/categories')
            .then(res => res.json())
            .then((data) => {
                data.recordsets[0].push({
                    "value": 0,
                    "label": "Todos los productos",
                    "description": ""
                });
                this.setState({categorias: data.recordsets[0]});
            })
            .catch(console.log)
    };

    getCities = () => {
        fetch('http://localhost:5000/cities')
            .then(res => res.json())
            .then((data) => {
                this.setState({cities: data.recordsets[0]});
            })
            .catch(console.log)
    };

    addProductInCart = (idProduct) => {
        let temproductsInCart = [...this.state.productsInCart];
        temproductsInCart.push({idProduct: idProduct, count: 1});
        this.setState(() => {
            return {
                productsInCart: temproductsInCart
            };
        }, this.addTotals);
    };

    isProductInCart = (idProduct) => {
        return this.state.productsInCart.find(item => item.idProduct === idProduct.toString()) !== undefined;

    };

    isProductInStock = (idProduct, quantity) => {
        const temStock = this.state.stock
        if (temStock.length > 0) {
            for (const i in temStock) {
                if (temStock[i].idProduct === idProduct && temStock[i].quantity >= quantity) {
                    return true
                }
            }
        }
        return false
    }

    getProductStock = (idProduct) => {
        const temStock = this.state.stock
        if (temStock.length > 0) {
            for (const i in temStock) {
                if (temStock[i].idProduct === idProduct) {
                    return temStock[i].quantity
                }
            }
        }
    }

    getProductSale = (idProduct) => {
        const temStock = this.state.stock
        if (temStock.length > 0) {
            for (const i in temStock) {
                if (temStock[i].idProduct === idProduct && temStock[i].quantity > 0) {
                    return temStock[i].sale
                }
            }
        }
        return 0
    }

    getItem = (idProduct) => {
        return this.state.productos.find(item => item.idProduct === idProduct);
    };

    handleDetail = (idProduct) => {
        const product = this.getItem(idProduct);
        this.setState(() => {
            return {detailProduct: product};
        });
    };

    openModal = idProduct => {
        const product = this.getItem(idProduct);
        this.setState(() => {
            return {modalProduct: product, modalOpen: true};
        });
    };

    openLoginModal = () => {
        this.setState({loginModalOpen: true})
    };

    openPaymentModal = () => {
        this.setState({paymentModalOpen: true})
    };

    openScoreModal = () => {
        this.setState({scoreModalOpen: true})
    };
    openSaleModal = () => {
        this.setState({saleModalOpen: true})
    };

    closeModal = () => {
        this.setState(() => {
            return {modalOpen: false};
        });
    };

    closeLoginModal = () => {
        this.setState({loginModalOpen: false})
    };

    closeScoreModal = () => {
        this.setState({scoreModalOpen: false})
    };

    closeSaleModal = () => {
        this.setState({saleModalOpen: false})
    };


    closePaymentModal = () => {
        this.setState({paymentModalOpen: false})
    };

    insertItemArray = (arr, index, newItem) => [
        // part of the array before the specified index
        ...arr.slice(0, index),
        // inserted item
        newItem,
        // part of the array after the specified index
        ...arr.slice(index)
    ]

    increment = idProduct => {
        let temProductsInCart = [...this.state.productsInCart];
        let temProduct = this.state.productsInCart.find(item => item.idProduct === idProduct.toString());
        let count = temProduct.count + 1;

        // delete old item
        const index = temProductsInCart.indexOf(temProduct);
        if (index > -1) {
            temProductsInCart.splice(index, 1);
        }
        // insert new item
        temProductsInCart = this.insertItemArray(temProductsInCart, index, {idProduct: idProduct, count: count});
        // this.setState({productsInCart: temProductsInCart});
        this.setState(() => {
            return {
                productsInCart: temProductsInCart
            };
        }, this.addTotals);
    };

    decrement = idProduct => {
        let temProductsInCart = [...this.state.productsInCart];
        let temProduct = this.state.productsInCart.find(item => item.idProduct === idProduct.toString());
        let count = temProduct.count - 1
        let index = temProductsInCart.indexOf(temProduct);

        if (count === 0) {
            this.removeItem(temProduct.idProduct)
        } else {
            if (index > -1) {
                temProductsInCart.splice(index, 1);
            }
            temProductsInCart = this.insertItemArray(temProductsInCart, index, {idProduct: idProduct, count: count});
            // this.setState({productsInCart: temProductsInCart})
            this.setState(() => {
                return {
                    productsInCart: temProductsInCart
                };
            }, this.addTotals);
        }
    };

    getTotals = () => {
        let subTotal = 0;
        let sale = 0;
        this.state.productsInCart.map(
            item => {
                let temProduct = this.getItem(item.idProduct)
                subTotal += temProduct.finalCost * item.count
                sale += temProduct.finalCost * this.getProductSale(temProduct.idProduct) / 100
                return subTotal
            }
        );

        const temDiscount = subTotal * (this.state.coupon / 100) + sale;
        const discount = parseFloat(temDiscount.toFixed(2));
        const tempTax = subTotal * 0.13;
        const tax = parseFloat(tempTax.toFixed(2));
        const temTotal = (subTotal - discount) + tax;
        const total = parseFloat(temTotal.toFixed(2));

        return {
            subTotal,
            discount,
            tax,
            total
        };
    };

    getSubsidiary = () => {
        let idSubsidiary = this.state.idSubsidiary;
        if (idSubsidiary === 1) {
            return 'Cartago'
        } else if (idSubsidiary === 2) {
            return 'San Jose'
        } else if (idSubsidiary === 3) {
            return 'Alajuela'
        }
    };

    addTotals = () => {
        const totals = this.getTotals();
        this.setState(
            () => {
                return {
                    cartSubTotal: totals.subTotal,
                    cartDiscount: totals.discount,
                    cartTax: totals.tax,
                    cartTotal: totals.total
                };
            },
            () => {
                // console.log(this.state);
            }
        );
    };

    removeItem = idProduct => {
        let temProductsInCart = [...this.state.productsInCart];
        let temProduct = this.state.productsInCart.find(item => item.idProduct === idProduct.toString());

        // romove an item
        const index = temProductsInCart.indexOf(temProduct);
        if (index > -1) {
            temProductsInCart.splice(index, 1);
        }
        this.setState(() => {
            return {
                productsInCart: temProductsInCart
            };
        }, this.addTotals);
    };

    clearCart = () => {
        this.setState(
            () => {
                return {productsInCart: []};
            },
            () => {
                this.addTotals();
            }
        );
    };

    render() {
        return (
            <ProductContext.Provider value={{
                ...this.state,
                handleDetail: this.handleDetail,
                openModal: this.openModal,
                closeModal: this.closeModal,
                openLoginModal: this.openLoginModal,
                closeLoginModal: this.closeLoginModal,
                openPaymentModal: this.openPaymentModal,
                closePaymentModal: this.closePaymentModal,
                openScoreModal: this.openScoreModal,
                closeScoreModal: this.closeScoreModal,
                openSaleModal: this.openSaleModal,
                closeSaleModal: this.closeSaleModal,
                addProductInCart: this.addProductInCart,
                isProductInCart: this.isProductInCart,
                increment: this.increment,
                decrement: this.decrement,
                removeItem: this.removeItem,
                getItem: this.getItem,
                clearCart: this.clearCart,
                setLoginPerson: this.setLoginPerson,
                setDelivery: this.setDelivery,
                getSPValidateCoupon: this.getSPValidateCoupon,
                registerPurchase: this.registerPurchase,
                registerPayment: this.registerPayment,
                registerScore: this.registerScore,
                getSubsidiary: this.getSubsidiary,
                getProductStock: this.getProductStock,
                getProductSale: this.getProductSale,
                isProductInStock: this.isProductInStock,
                updateStock: this.updateStock,
            }}>
                {this.props.children}
            </ProductContext.Provider>
        );
    }
}

export default ProductProvider;


const
    ProductConsumer = ProductContext.Consumer;

export {
    ProductProvider
    ,
    ProductConsumer
};
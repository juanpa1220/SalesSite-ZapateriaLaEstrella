import React from 'react';
import {Switch, Route} from 'react-router-dom';
import './App.css';
import 'bootstrap/dist/css/bootstrap.min.css';
import Navbar from "./components/Navbar";
import ProductList from "./components/ProductList";
import Details from "./components/Details";
import Cart from "./components/Cart/Cart";
import Modal from "./components/Modal"
import Default from "./components/Default";
import LoginModal from "./components/Login/LoginModal";
import Admin from "./components/Admin/Admin";
import ScoreModal from "./components/Cart/Score";
import SaleModal from "./components/Admin/SaleModal";

function App() {
    return (
        <React.Fragment>
            <Navbar/>
            <Switch>
                <Route exact path="/" component={ProductList}/>
                <Route path="/details" component={Details}/>
                <Route path="/cart" component={Cart}/>
                <Route path="/admin" component={Admin}/>
                <Route component={Default}/>
            </Switch>
            <Modal/>
            <LoginModal/>
            <ScoreModal/>
            <SaleModal/>
        </React.Fragment>
    );
}

export default App;

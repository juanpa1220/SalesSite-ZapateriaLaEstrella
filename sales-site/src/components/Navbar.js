import React, {Component} from 'react';
import {Link} from 'react-router-dom';
import logo from '../logo.svg';
import {ButtonContainer} from "./Button";
import styled from "styled-components";
import {ProductConsumer} from "../context";

class Navbar extends Component {
    render() {
        return (
            <NavWrapper className="navbar navbar-expand-sm navbar-dark px-sm-5">
                {/*https://www.iconfinder.com/icons/1243689/call_phone_icon
                Creative Commons (Attribution 3.0 Unported);
                https://www.iconfinder.com/Makoto_msk */}
                <Link to="/">
                    <img src={logo} alt="store" className="navbar-brand"/>
                </Link>
                <ul className="navbar-nav align-items-center">
                    <li className="nav-item ml-1">
                        <Link to="/" className="nav-link">
                            Productos
                        </Link>
                    </li>
                </ul>


                <Link to="/cart" className="ml-auto">
                    <ButtonContainer>
                        <span className="mr-2">
                            <i className="fas fa-cart-plus"/>
                        </span>
                        Mi Carrito
                    </ButtonContainer>
                </Link>


                <ProductConsumer>
                    {value => {
                        if (value.loginPerson.length === 0) {
                            return (
                                <ButtonContainer className="ml-2"
                                                 disabled={!value.loginPerson}
                                                 onClick={() => {
                                                     value.openLoginModal()
                                                 }
                                                 }>
                                    Iniciar Sesion
                                </ButtonContainer>

                            )
                        } else {
                            if (value.isDelivery) {
                                return (
                                    <ButtonContainer className="ml-2"
                                                     disabled={!value.loginPerson}
                                                     onClick={() => {
                                                         value.openScoreModal()
                                                     }
                                                     }>
                                        Calificar Delivery
                                    </ButtonContainer>)
                            } else {
                                if (value.isAdmin) {
                                    return (
                                        <Link to="/admin">
                                            <ButtonContainer>
                                                Admin
                                            </ButtonContainer>
                                        </Link>
                                    )
                                }
                                return (
                                    <ul className="navbar-nav align-items-center">
                                        <li className="nav-link ml-2">
                                            Bienvenido {value.loginPerson.username}
                                        </li>
                                    </ul>
                                )
                            }

                        }

                    }}
                </ProductConsumer>

            </NavWrapper>

        );
    }
}

export default Navbar;

const NavWrapper = styled.nav`
background: var(--mainBlue);
.nav-link{
    color: var(--mainWhiteWrapper) !important;
    font-size: 1.3rem;
    text-transform: capitalize;
}
`;

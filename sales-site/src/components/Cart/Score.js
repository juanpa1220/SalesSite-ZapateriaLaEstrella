import React, {Component} from 'react';
import styled from "styled-components";
import {ProductConsumer} from "../../context";
import 'react-day-picker/lib/style.css';
import StarRatingComponent from 'react-star-rating-component';

export default class ScoreModal extends Component {

    constructor(props) {
        super(props);
        this.state = {
            isLoginOpen: true,
            isRegisterOpen: false
        };
    }

    showLoginBox() {
        this.setState({isLoginOpen: true, isRegisterOpen: false});
    }

    showRegisterBox() {
        this.setState({isRegisterOpen: true, isLoginOpen: false});
    }


    render() {
        return (
            <ProductConsumer>
                {value => {
                    const {scoreModalOpen, closeScoreModal} = value;
                    if (!scoreModalOpen) {
                        return null;
                    } else {
                        return (
                            <ProductConsumer>
                                {value => {
                                    return (
                                        <ModalContainer>
                                            <div className="container">
                                                <div className="row">
                                                    <div
                                                        className="col-8 mx-auto col-md-6 col-lg-4 p-5 text-center text-capitalize"
                                                        id="modal">

                                                        <div className="root-container">

                                                            <div className="box-container">
                                                                <ScoreBox value={value}/>
                                                            </div>

                                                            <button
                                                                type="button"
                                                                className="login-btn mr-auto ml-auto"
                                                                onClick={closeScoreModal}>
                                                                Cancelar
                                                            </button>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </ModalContainer>
                                    )
                                }}
                            </ProductConsumer>

                        );
                    }
                }}
            </ProductConsumer>
        );
    }
}

const ModalContainer = styled.div`
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  #modal {
    background: var(--mainWhite);
  }
`;

class ScoreBox extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            confirmed: false,
            comment: '',
            rating: 3,
        };
    }

    onCommentChange(e) {
        this.setState({comment: e.target.value})
    }

    onStarClick(value) {
        console.log(value)
        this.setState({rating: value});
    }

    render() {
        const {scoreModalOpen, setDelivery, closeScoreModal, registerScore} = this.props.value;
        if (!scoreModalOpen) {
            return null;
        } else {
            return (
                <div className="inner-container">
                    <div className="header">
                        Califica tu Servicio de Delivery
                    </div>
                    <div className="box">

                        <div className="input-group align-items-center" hidden={this.state.confirmed}>
                            <label htmlFor="username">Calificación</label>
                            <StarRatingComponent
                                starColor={'var(--lightBlue)'}
                                emptyStarColor={'var(--mainDark)'}
                                name="rate1"
                                starCount={5}
                                value={this.state.rating}
                                onStarClick={this.onStarClick.bind(this)}
                            />
                        </div>

                        <div className="input-group" hidden={this.state.confirmed}>
                            <label htmlFor="username">Comentario</label>
                            <input
                                type="text"
                                name="username"
                                className="login-input"
                                placeholder="Comentario"
                                onChange={this
                                    .onCommentChange
                                    .bind(this)}
                            />
                        </div>

                        <button
                            type="button"
                            className="login-btn"
                            disabled={this.state.confirmed}
                            hidden={this.state.confirmed}
                            onClick={
                                () => {
                                    registerScore(this.state.comment, this.state.rating);
                                    setDelivery(false);
                                    this.setState({confirmed: true});
                                }
                            }>
                            Enviar
                        </button>
                        <small className="coupon-applied">{this.state.confirmed
                            ? 'Su calificacion ha sido registrada.\n¡Gracias por ayudarnos a mejorar!'
                            : ""}</small>
                        <button
                            type="button"
                            className="login-btn"
                            disabled={!this.state.confirmed}
                            hidden={!this.state.confirmed}
                            onClick={
                                () => {
                                    closeScoreModal();
                                }
                            }>
                            Aceptar
                        </button>

                    </div>
                </div>
            );
        }
    }

}
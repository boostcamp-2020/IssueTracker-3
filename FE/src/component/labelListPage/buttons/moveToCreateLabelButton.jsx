import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToCreateLabelButton = styled.button`
  display: flex;
  border: 1px solid forestgreen;
  margin: 5px;
  margin-top: 5px;
  margin-bottom: 5px;
  margin-left: 400px;
  margin-right: 5px;
  color: white;
  border-radius: 5px;
  background-color: #33cc33;
`;
function MoveToCreateLabelButton(prop) {
  return <StyledMoveToCreateLabelButton onClick={prop.event}> New Label </StyledMoveToCreateLabelButton>;
}

export default hot(module)(MoveToCreateLabelButton);

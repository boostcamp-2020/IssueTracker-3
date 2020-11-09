import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledMoveToMaileStoneButton = styled.button`
  display: flex;
  border: 1px solid gray;
  background-color: white;
  font-weight: bold;
  margin: 5px 0px;
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;

  &:hover {
    background-color: aquamarine;
  }
`;
function MoveToMaileStoneButton() {
  return (
    <Link to="./milestonelist" style={{ textDecoration: "none" }}>
      <StyledMoveToMaileStoneButton>마일스톤</StyledMoveToMaileStoneButton>
    </Link>
  );
}

export default hot(module)(MoveToMaileStoneButton);

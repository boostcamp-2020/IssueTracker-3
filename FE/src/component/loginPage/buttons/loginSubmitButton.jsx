import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StyledSubmitButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function SubmitButton() {
  return (
    <Link to="./issuelist">
      <StyledSubmitButton> 로그인 하기 </StyledSubmitButton>
    </Link>
  );
}
export default hot(module)(SubmitButton);

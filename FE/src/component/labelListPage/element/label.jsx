import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledLabel = styled.div`
  display: flex;
  border: 0px solid gray;
  margin: 4px;
`;
function Label(props) {
  const { name, color, description } = props;
  const Combination = styled.span`
    width: 25%;
    background-color: ${color || "RED"};
  `;
  const Separate = styled.span`
    width: 25%;
  `;
  return (
    <StyledLabel>
      <Combination>{name}</Combination>
      <Separate>{description}</Separate>
      <Separate />
      <Separate>
        <span>edit </span>
        <span> delete</span>
      </Separate>
    </StyledLabel>
  );
}

export default hot(module)(Label);

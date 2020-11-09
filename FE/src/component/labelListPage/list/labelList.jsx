import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledLabelList = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  flex-direction: column;
`;
const StyledLabelHeader = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
const StyledLabel = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LabelList() {
  const animalList = ["dog", "cat", "tiger"];

  return (
    <StyledLabelList>
      <StyledLabelHeader>Label List header</StyledLabelHeader>
      {animalList.map((animal, index) => (
        <Label key={index} name={animal} />
      ))}
    </StyledLabelList>
  );
}

function Label({ name }) {
  return (
    <StyledLabel>
      <span>{name}</span>
    </StyledLabel>
  );
}

export default hot(module)(LabelList);

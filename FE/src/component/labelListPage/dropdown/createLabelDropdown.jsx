import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const StyledCreateLabelDropdown = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
const Seperate = styled.div`
  display: flex;
`;
function CreateLabelDropdown() {
  const newLabelName = "LabelName";

  const newLableColor = "#bfdadc";

  const StyledPreview = styled.span`
    display: flex;
  `;
  return (
    <StyledCreateLabelDropdown>
      <div></div>
      <div>
        <div></div>
        <div></div>
        <div></div>
        <div></div>
      </div>
    </StyledCreateLabelDropdown>
  );
}

export default hot(module)(CreateLabelDropdown);

import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const Horizontal = styled.div`
  display: flex;
  border: 1px dotted black;
  flex-direction: row;
`;
const Vertical = styled.div`
  display: flex;
  border: 1px dotted black;
  flex-direction: column;
`;
function CreateLabelDropdown() {
  const newLabelName = "LabelName";

  const newLableColor = "#bfdadc";

  const Dropdown = "flex";
  const StyledCreateLabelDropdown = styled.div`
    display: ${Dropdown};
    border: 1px dotted black;
    margin: 5px;
    flex-direction: column;
  `;

  const StyledPreview = styled.span`
    display: flex;
  `;
  return (
    <StyledCreateLabelDropdown>
      <StyledPreview>{newLabelName}</StyledPreview>
      <Horizontal>
        <Vertical>
          <span>이름</span>
          <input></input>
        </Vertical>
        <Vertical>
          <span>설명</span>
          <input></input>
        </Vertical>
        <Vertical>
          <span>색상</span>
          <input></input>
        </Vertical>
        <Horizontal>
          <button>만들기</button>
          <button>취소</button>
        </Horizontal>
      </Horizontal>
    </StyledCreateLabelDropdown>
  );
}

export default hot(module)(CreateLabelDropdown);

import React, { useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { debounce } from "lodash";

import axiosApi from "../../../util/axiosApi";

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
function CreateLabelDropdown(props) {
  const newLabelName = "LabelName";

  const StyledCreateLabelDropdown = styled.div`
    display: ${props.visible};
    border: 1px dotted black;
    margin: 5px;
    flex-direction: column;
  `;

  const StyledPreview = styled.span`
    display: flex;
  `;
  const [data, setData] = useState({ name: "", description: "", color: "" });

  const onNameHandler = (event) => {
    const inputName = event.target.value;
    // props.setData({ name: event.target.value, description: "", color: "" });
    setData({ name: inputName, description: data.description, color: data.color });
  };
  const onDescriptionHandler = (event) => {
    const inputDescription = event.target.value;
    setData({ name: data.name, description: inputDescription, color: data.color });
  };
  const onColorHander = (event) => {
    const inputColor = event.target.value;
    setData({ name: data.name, description: data.description, color: inputColor });
  };

  const debouncedNameHandler = debounce(onNameHandler, 1000);
  const debouncedDescriptionHandler = debounce(onDescriptionHandler, 1000);
  const debouncedColorHander = debounce(onColorHander, 1000);

  const newLabel = async () => {
    console.log(data);
    if (data.name.length === 0) {
      alert("이름을 입력하세요 !");
      return;
    }
    if (data.color.length === 0) {
      alert("색상을 입력하세요 !");
      return;
    }
    const result = await axiosApi("/label", "POST", data);
    if (result.status === 200) {
      const response = await axiosApi("/label", "GET");
      props.setLabels(response.data);
    }
  };
  return (
    <StyledCreateLabelDropdown>
      <StyledPreview>{newLabelName}</StyledPreview>
      <Horizontal>
        <Vertical>
          <span>이름</span>
          <input type="text" name="name" defaultValue={data.name} onChange={debouncedNameHandler}></input>
        </Vertical>
        <Vertical>
          <span>설명</span>
          <input type="text" name="description" defaultValue={data.description} onChange={debouncedDescriptionHandler}></input>
        </Vertical>
        <Vertical>
          <span>색상</span>
          <input type="text" name="color" defaultValue={data.color} onChange={debouncedColorHander}></input>
        </Vertical>
        <Horizontal>
          <button onClick={newLabel}>만들기</button>
          <button onClick={props.event}>취소</button>
        </Horizontal>
      </Horizontal>
    </StyledCreateLabelDropdown>
  );
}

export default hot(module)(CreateLabelDropdown);

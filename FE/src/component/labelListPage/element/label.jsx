import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

import axiosApi from "../../../util/axiosApi";

const StyledLabel = styled.div`
  display: flex;
  border: 0px solid gray;
  margin: 4px;
`;
function Label(props) {
  const { labelid, name, color, description, setLabels } = props;
  const Combination = styled.span`
    width: 25%;
    background-color: ${color || "RED"};
  `;
  const Separate = styled.span`
    width: 25%;
  `;
  const editLabel = async (event) => {
    const response = await axiosApi("/label", "GET");
    setLabels(response.data);
  };
  const deleteLabel = async (event) => {
    await axiosApi("/label", "DELETE", { id: labelid });
    const response = await axiosApi("/label", "GET");
    setLabels(response.data);
  };
  return (
    <StyledLabel>
      <Combination>{name}</Combination>
      <Separate>{description}</Separate>
      <Separate />
      <Separate>
        <span onClick={editLabel}>edit </span>
        <span onClick={deleteLabel}> delete</span>
      </Separate>
    </StyledLabel>
  );
}

export default hot(module)(Label);

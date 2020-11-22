import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import axiosApi from "../../../util/axiosApi";

const StylednewMilestoneButton = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 60px;
  color: black;
  font-weight: bold;
  margin: 5px 0px;
`;
function EditMilestone({ id }) {
  return <StylednewMilestoneButton>Edit</StylednewMilestoneButton>;
}

export default hot(module)(EditMilestone);

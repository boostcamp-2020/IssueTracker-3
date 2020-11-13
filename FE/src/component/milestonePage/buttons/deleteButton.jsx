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
function DeleteMilestone({ id }) {
  const deleteMilestone = async (e) => {
    console.log(`click`);
    const result = await axiosApi("http://localhost:3000/milestone", "DELETE", { id });
    if (result.status === 200) console.log("성공");
  };
  return <StylednewMilestoneButton onClick={deleteMilestone}>Delete</StylednewMilestoneButton>;
}

export default hot(module)(DeleteMilestone);

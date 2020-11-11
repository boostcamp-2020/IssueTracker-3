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
function CloseMilestone({ id }) {
  const closeMilestone = async (e) => {
    const result = await axiosApi(`http://localhost:3000/milestone/${id}/state/0`, "PATCH");
    if (result === 200) console.log(`closed`);
  };
  return <StylednewMilestoneButton onClick={closeMilestone}>Close</StylednewMilestoneButton>;
}

export default hot(module)(CloseMilestone);

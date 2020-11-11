import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StylednewMilestoneButton = styled.button`
  display: flex;
  border: 1px solid gray;
  background-color: green;
  color: white;
  font-weight: bold;
  margin: 5px 0px;
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;
`;
function NewMilestone() {
  return (
    <Link to="./milestonecreate" style={{ textDecoration: "none" }}>
      <StylednewMilestoneButton>New Milestone</StylednewMilestoneButton>
    </Link>
  );
}

export default hot(module)(NewMilestone);

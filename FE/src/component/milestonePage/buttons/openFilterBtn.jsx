import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";

const StylednewMilestoneButton = styled.button`
  display: flex;
  color: black;
  font-weight: bold;
  margin: 5px 0px;
`;
function OpenMilestoneButton(props) {
  return (
    <Link to="./" style={{ textDecoration: "none" }}>
      <StylednewMilestoneButton>{props.open} Open</StylednewMilestoneButton>
    </Link>
  );
}

export default hot(module)(OpenMilestoneButton);

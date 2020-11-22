import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import OpenMilestoneButton from "../buttons/openFilterBtn";
import ClosedMilestoneButton from "../buttons/closeFilterBtn";

const StylednewListHeader = styled.div`
  display: flex;
  align-items: center;
  width: 100%;
  height: 50px;
  border: 1px dotted black;
  box-sizing: border-box;
  background-color: #dfe6e9;
  padding: 10px;
`;

function ListHeader(props) {
  return (
    <StylednewListHeader>
      <OpenMilestoneButton open={props.open} />
      <ClosedMilestoneButton close={props.close} />
    </StylednewListHeader>
  );
}

export default hot(module)(ListHeader);

import axios from "axios";
import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MoveToLabelButton from "../labelListPage/buttons/moveToLabelButton";
import MoveToMaileStoneButton from "../labelListPage/buttons/moveToMilestoneButton";
import NewMilestoneButton from "./buttons/newMilestoneButton";

const DivButtonWrapper = styled.div`
  display: flex;
  width: 100%;
  height: 50px;
  border: 1px dotted black;
  box-sizing: border-box;
  justify-content: space-between;
`;

const ButtonColumn = styled.div`
  height: 100%;
  border: 1px dotted black;
  box-sizing: border-box;
  display: flex;
  align-items: center;
`;
function MilestoneListHeader() {
  return (
    <DivButtonWrapper>
      <ButtonColumn>
        <MoveToLabelButton></MoveToLabelButton>
        <MoveToMaileStoneButton></MoveToMaileStoneButton>
      </ButtonColumn>
      <ButtonColumn>
        <NewMilestoneButton></NewMilestoneButton>
      </ButtonColumn>
    </DivButtonWrapper>
  );
}

export default hot(module)(MilestoneListHeader);

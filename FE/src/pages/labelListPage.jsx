import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MoveToCreateLabelButton from "../component/labelListPage/buttons/moveToCreateLabelButton";
import MoveToLabelButton from "../component/labelListPage/buttons/moveToLabelButton";
import MoveToMaileStoneButton from "../component/labelListPage/buttons/moveToMilestoneButton";
import LabelFilter from "../component/labelListPage/filter/labelFilter";
import LabelList from "../component/labelListPage/list/labelList";

const StyledLabelListPage = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  flex-direction: column;
`;
const Header = styled.div`
  display: flex;
  flex-direction: row;
  flex: 2 3 5;
`;
const Combination = styled.div`
  display: flex;
  flex-direction: row;
`;
const Body = styled.div`
  display: flex;
`;
function LabelListPage() {
  return (
    <StyledLabelListPage>
      <Header>
        <Combination>
          <MoveToLabelButton />
          <MoveToMaileStoneButton />
        </Combination>
        <LabelFilter />
        <MoveToCreateLabelButton />
      </Header>
      <Body>
        <LabelList />
      </Body>
    </StyledLabelListPage>
  );
}

export default hot(module)(LabelListPage);

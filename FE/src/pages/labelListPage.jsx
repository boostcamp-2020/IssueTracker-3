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
`;
function LabelListPage() {
  return (
    <StyledLabelListPage>
      <div>
        <LabelFilter />
        <MoveToCreateLabelButton />
        <div>
          <MoveToLabelButton />
          <MoveToMaileStoneButton />
        </div>
      </div>
      <div>
        <LabelList />
      </div>
    </StyledLabelListPage>
  );
}

export default hot(module)(LabelListPage);

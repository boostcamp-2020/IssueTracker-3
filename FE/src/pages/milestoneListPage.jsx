import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MilestoneList from "../component/milestonePage/list/milestoneList";
import ListHeader from "../component/milestonePage/list/milestoneListHeader";
import MilestoneListHeader from "../component/milestonePage/buttonWrapper";
import axiosApi from "../util/axiosApi";

const StyledMilestoneListPage = styled.div`
  display: flex;
  width: 100%;
  flex-direction: column;
  align-items: center;
  border: 1px dotted black;
  box-sizing: border-box;
  margin: 5px;
`;

const Main = styled.main`
  width: 85%;
  padding: 20px 0px;
  display: flex;
  flex-direction: column;
  border: 1px dotted black;
  box-sizing: border-box;
`;

const DivListWrapper = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  margin-top: 20px;
  border: 1px dotted black;
  box-sizing: border-box;
`;

function MilestoneListPage() {
  const [milestone, setMilestones] = useState([]);
  useEffect(async () => {
    const response = await axiosApi("/milestone","GET");
    setMilestones(response.data);
  }, []);

  let open = 0;
  let close = 0;

  milestone.forEach((element) => {
    if (element.state === 1) open += 1;
    else close += 1;
  });

  return (
    <StyledMilestoneListPage>
      <Main>
        <MilestoneListHeader />
        <DivListWrapper>
          <ListHeader open={open} close={close} />
          <MilestoneList milestones={milestone} />
        </DivListWrapper>
      </Main>
    </StyledMilestoneListPage>
  );
}

export default hot(module)(MilestoneListPage);

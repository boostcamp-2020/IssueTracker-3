import React, { useEffect, useState } from "react";
import axios from "axios";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import Progress from "./progressbar";
import Information from "./information";
import DeleteMilestone from "./buttons/deleteButton";
import EditMilestone from "./buttons/editButton";
import CloseMilestone from "./buttons/closeButton";

const StyledMilestoneState = styled.div`
  width: 50%;
  border: 1px dotted black;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  padding: 10px;
  justify-content: space-between;
`;

const ButtonWrapper = styled.div`
  display: flex;
`;

function MilestoneState({ id }) {
  const [issues, setIssues] = useState([]);
  useEffect(async () => {
    const response = await axios.get("http://101.101.210.34:3000/issue");
    setIssues(response.data);
  }, []);

  const filterIssues = issues.filter((issue) => {
    return +issue.milestone_id === id;
  });

  const total = filterIssues.length;
  let open = 0;
  let close = 0;
  filterIssues.forEach((element) => {
    if (element.state === 1) open += 1;
    else if (element.state === 0) close += 1;
  });
  const percent = Math.floor((close / total) * 100);
  return (
    <StyledMilestoneState>
      <Progress percent={percent} />
      <Information percent={percent} open={open} close={close} />
      <ButtonWrapper>
        <EditMilestone id={id} />
        <CloseMilestone id={id} />
        <DeleteMilestone id={id} />
      </ButtonWrapper>
    </StyledMilestoneState>
  );
}

export default hot(module)(MilestoneState);

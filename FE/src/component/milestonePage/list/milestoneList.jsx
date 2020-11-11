import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import MilestoneState from "../milestoneState";

const StyledMilestoneList = styled.div`
  display: flex;
  flex-direction: column;
  width: 100%;
  border: 1px dotted black;
  box-sizing: border-box;
`;

const StyledMilestone = styled.div`
  display: flex;
  width: 100%;
  border: 1px dotted black;
  box-sizing: border-box;
`;

function MilestoneList(props) {
  const { milestones } = props;
  return (
    <StyledMilestoneList>
      {milestones.map((milestone) => (
        <Milestone id={milestone.id} name={milestone.name} description={milestone.description} due_date={milestone.due_date}></Milestone>
      ))}
    </StyledMilestoneList>
  );
}

function Milestone({ id, name, description, due_date }) {
  let date = "";
  if (due_date) date = `Due By ${new Date(due_date).toLocaleDateString()}`;
  const Column = styled.div`
    width: 50%;
    border: 1px dotted black;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    padding: 10px;
    justify-content: space-between;
  `;
  const Title = styled.span`
    font-size: 28px;
    color: black;
  `;
  const Description = styled.span`
    font-size: 14px;
    color: #b2bec3;
  `;
  return (
    <StyledMilestone>
      <Column>
        <Title>{name}</Title>
        <Description>{date}</Description>
        <Description>{description}</Description>
      </Column>
      <MilestoneState id={id}></MilestoneState>
    </StyledMilestone>
  );
}

export default hot(module)(MilestoneList);

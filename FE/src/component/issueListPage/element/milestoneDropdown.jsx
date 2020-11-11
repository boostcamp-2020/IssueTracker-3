import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import ModalDropdown from "react-dropdown";

const Styled = styled.div`
  margin-right: 20px;
`;

function MilestoneDropdown(props) {
  const { milestones, setCondition, condition } = props;
  const milestoneOption = milestones.map((milestone) => {
    return { value: milestone.name, label: milestone.name };
  });
  milestoneOption.unshift({ label: "issue with no milestone", value: "empty" });
  milestoneOption.unshift({ label: "milestone", value: null });
  const onMilestoneHandler = (event) => {
    setCondition({ label: condition.label, milestone: event.value, user: condition.user });
  };
  return (
    <Styled>
      <ModalDropdown options={milestoneOption} value={null} onChange={onMilestoneHandler} placeholder="milestone" />
    </Styled>
  );
}

export default hot(module)(MilestoneDropdown);

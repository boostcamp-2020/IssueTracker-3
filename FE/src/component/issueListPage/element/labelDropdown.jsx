import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import ModalDropdown from "react-dropdown";

const Styled = styled.div`
  margin-right: 20px;
`;
function LabelDropdown(props) {
  const { labels, setCondition, condition } = props;
  const labelOption = labels.map((label) => {
    return { value: label.name, label: label.name };
  });
  labelOption.unshift({ label: "issue with no label", value: "empty" });
  labelOption.unshift({ label: "label", value: null });
  const onLabelHandler = (event) => {
    setCondition({ label: event.value, milestone: condition.milestone, user: condition.user });
  };
  return (
    <Styled>
      <ModalDropdown options={labelOption} value={null} onChange={onLabelHandler} placeholder="label" />
    </Styled>
  );
}

export default hot(module)(LabelDropdown);

import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import Label from "@component/labelListPage/element/label";

const StyledLabelList = styled.div`
  display: flex;
  width: 100%;
  border: 1px solid gray;
  margin: 5px;
  flex-direction: column;
`;
const StyledLabelHeader = styled.div`
  display: flex;
  border: 1px solid gray;
  margin: 5px;
`;

function LabelList(props) {
  const { labels, setLabels } = props;
  return (
    <StyledLabelList>
      <StyledLabelHeader>Label List header</StyledLabelHeader>
      {labels?.map((label, index) => (
        <Label key={index} labelid={label.id} name={label.name} color={label.color} description={label.description} setLabels={setLabels} />
      ))}
    </StyledLabelList>
  );
}

export default hot(module)(LabelList);

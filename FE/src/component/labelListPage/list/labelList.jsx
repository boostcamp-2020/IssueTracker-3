import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import useRequest from "../../../util/useRequest";

const StyledLabelList = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  flex-direction: column;
`;
const StyledLabelHeader = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
const StyledLabel = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function LabelList() {
  const [response, loading, error] = useRequest("http://101.101.210.34:3000/label");
  if (loading) {
    return <div>로딩중..</div>;
  }
  if (error) {
    return <div>에러 발생!</div>;
  }
  if (!response) return null;

  const labels = response.data;
  return (
    <StyledLabelList>
      <StyledLabelHeader>Label List header</StyledLabelHeader>
      {labels.map((label, index) => (
        <Label key={index} name={label.name} color={label.color} description={label.description} />
      ))}
    </StyledLabelList>
  );
}

function Label({ name, color, description }) {
  const Combination = styled.span`
    border: 1px dotted black;
    background-color: ${color || "RED"};
  `;
  return (
    <StyledLabel>
      <Combination>{name}</Combination>
      <span>{description}</span>
    </StyledLabel>
  );
}

export default hot(module)(LabelList);

import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";
import useRequest from "../../../util/useRequest";

const StyledMoveToMilestoneButton = styled.button`
  display: flex;
  border: 1px solid gray;
  background-color: white;
  font-weight: bold;
  margin: 5px 0px;
  border-top-right-radius: 4px;
  border-bottom-right-radius: 4px;

  &:hover {
    background-color: aquamarine;
  }
`;
const StyledNumber = styled.span`
  border: 1px solid gray;
  border-radius: 1px;
  background-color: gray;
  font-weight: bold;
  margin: 0px 3px;
`;
function MoveToMilestoneButton() {
  const [response, loading, error] = useRequest("http://101.101.210.34:3000/milestone");
  if (loading) {
    return <div>로딩중..</div>;
  }
  if (error) {
    return <div>에러 발생!</div>;
  }
  if (!response) return null;

  const numbers = response.data.length;
  return (
    <Link to="./milestonelist" style={{ textDecoration: "none" }}>
      <StyledMoveToMilestoneButton>
        마일스톤<StyledNumber>{numbers}</StyledNumber>
      </StyledMoveToMilestoneButton>
    </Link>
  );
}

export default hot(module)(MoveToMilestoneButton);

import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";
import useRequest from "../../../util/useRequest";

const StyledMoveToLabelButton = styled.button`
  display: flex;
  border: 1px solid gray;
  background-color: white;
  font-weight: bold;
  margin: 5px 0px;
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;

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
function MoveToLabelButton() {
  const [response, loading, error] = useRequest("http://101.101.210.34:3000/label");
  if (loading) {
    return <div>로딩중..</div>;
  }
  if (error) {
    return <div>에러 발생!</div>;
  }
  if (!response) return null;

  const numbers = response.data.length;

  return (
    <Link to="./labellist" style={{ textDecoration: "none" }}>
      <StyledMoveToLabelButton>
        라벨<StyledNumber>{numbers}</StyledNumber>
      </StyledMoveToLabelButton>
    </Link>
  );
}

export default hot(module)(MoveToLabelButton);

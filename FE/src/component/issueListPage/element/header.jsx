import React, { useEffect, useState } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import axiosApi from "../../../util/axiosApi";

function IssueHeader(props) {
  const { issue, setIssue } = props;
  const [condition, setCondition] = useState({ state: null, author: null, assignee: null, comment: null });
  useEffect(async () => {
    const response = await axiosApi("/issue/filter", "GET");
    setIssue(response.data);
  }, [condition]);
  return <div> HEADER </div>;
}

export default hot(module)(IssueHeader);

import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";

const styledIssueCreate = styled.div`
    display : flex,
    border : dot 1px,
    box-size : border-box
`;

const IssueCreate = () => <styledIssueCreate>IssueCreatePage</styledIssueCreate>;

export default hot(module)(IssueCreate);

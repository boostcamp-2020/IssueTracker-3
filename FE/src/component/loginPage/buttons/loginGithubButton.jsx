import React from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Link } from "react-router-dom";
import axiosApi from "@util/axiosApi";

const StyledGithubButton = styled.button`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
`;
function GithubButton() {
  const githubLogin = async () => {
    const res = await axiosApi("/auth/github", "GET");
  };
  return (
    <Link to="./github">
      <StyledGithubButton onClick={githubLogin}> 깃허브로 로그인 하기 </StyledGithubButton>
    </Link>
  );
}

export default hot(module)(GithubButton);

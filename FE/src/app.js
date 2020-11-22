import React, { useState,useEffect } from "react";
import { hot } from "react-hot-loader";
import styled from "styled-components";
import { Switch, Route, BrowserRouter } from "react-router-dom";

import LoginPage from "@pages/loginPage";
import IssueListPage from "@pages/issueListPage";
import IssueDetailPage from "@pages/issueDetailPage";
import IssueCreatePage from "@pages/issueCreatePage";
import LabelListPage from "@pages/labelListPage";
import MilestoneCreatePage from "@pages/milestoneCreatePage";
import MilestoneListPage from "@pages/milestoneListPage";
import RegisterPage from "@pages/registerPage";
import Callback from "@pages/callback";
import axiosApi from "@util/axiosApi";

const StyledContent = styled.div`
  display: flex;
  border: 1px dotted black;
  margin: 5px;
  justify-content: center;
  align-items: center;
`;
const App = () => {
  const [user, setUser] = useState({
    id: 0,
    name: "",
    url: "",
  });
  useEffect(async () => {
    if (localStorage.getItem("token") !== null) {
      const userInfo = await axiosApi("/auth", "GET");
      setUser({ id: userInfo.data.token_id, name: userInfo.data.token_name, url: "" });
    }
  }, []);
  return (
    <StyledContent>
      <BrowserRouter>
        <Switch>
          <Route
            exact
            path="/"
            render={() => {
              return user.id === 0 ? <LoginPage User={user} setUser={setUser} /> : <IssueListPage user={user} />;
            }}
          />
          <Route exact path="/issuelist" component={IssueListPage} />
          <Route exact path="/issuedetail/:id" component={IssueDetailPage} />
          <Route exact path="/issuecreate" component={IssueCreatePage} />
          <Route exact path="/labellist" component={LabelListPage} />
          <Route exact path="/milestonecreate" component={MilestoneCreatePage} />
          <Route exact path="/milestonelist" component={MilestoneListPage} />
          <Route exact path="/register" component={RegisterPage} />
          <Route exact path="/callback" component={Callback} />
        </Switch>
      </BrowserRouter>
    </StyledContent>
  );
};

export default hot(module)(App);

export interface Issue {
  id: number;
  title: string;
  body: string;
  userID: number;
  state: boolean;
  milestoneID: number;
  createdAt: Date;
  closedAt: Date;
}

export interface Comment {
  id: number;
  issueID: number;
  userID: number;
  body: string;
  emoji: string;
  createdAt: Date;
}

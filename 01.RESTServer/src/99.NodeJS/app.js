const express = require('express');
const app = express();
const router = express.Router();

// 라우터에 경로 정의
router.get('/hello', (req, res) => {
  res.json({ response: 'Hello, World' });
});

// 애플리케이션에 라우터 등록
app.use('/api', router);

app.listen(3000, () => {
  console.log('서버가 3000번 포트에서 실행 중입니다.');
});
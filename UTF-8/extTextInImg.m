%% 画像のデータを読み込む
% 画像ファイルの選択
uiwait(msgbox('データの埋め込まれた画像を選択してください。'));
[FileName, PathName, FilterIndex] = uigetfile({'*.png;*.bmp;*.gif;*.jpg;*.jpeg', '画像ファイル(*.bmp,*.png,*.gif,*.jpg,*.jpeg)'}, '埋め込み画像選択');
if FilterIndex == 0
    disp('ファイルがありません。');
    uiwait(msgbox('ファイルが存在しません。', '', 'error'));
    return;
else

% 画像読み込み
ImgPath = fullfile(PathName, FileName);
img = imread(ImgPath);
% imshow(img);

% データ抽出
% RGB各々の下位2bitsを抽出する
bytes = uint8([]);
k = 1;
seekbar = waitbar(0, '抽出中...');
while numel(img) >= k
  char = 0;
  for i = 0 : -2 : -6
    char = char + bitshift(bitshift(img(k), 6), i);
    k = k + 1;
    waitbar(k / numel(img));
  end;
  if char == 0, break, end;
  bytes((k - 1) / 4) = char;
end;
waitbar(1);
pause(1);
close(seekbar);

% 抽出データの保存先選択
uiwait(msgbox('抽出データの保存先を選択してください。'));
[FileName, PathName, FilterIndex] = uiputfile({'*.*', 'ファイル(*.*)'}, 'データ保存先選択');
if FilterIndex == 0
    disp('ファイルが選択されていません。');
    uiwait(msgbox('ファイルが選択されていません。', '', 'error'));
    return;
else

% 抽出データの出力
bytes = transpose(bytes);
FilePath = fullfile(PathName, FileName);
fileID = fopen(FilePath, 'w');
bytes = fwrite(fileID, bytes, 'uint8');
fclose(fileID);

% ファイル出力
disp('ファイルを出力しました。');
disp(FilePath);
uiwait(msgbox(['ファイルを出力しました。', 10, FilePath]));

end;
end;

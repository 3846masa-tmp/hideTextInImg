%% �摜�̃f�[�^��ǂݍ���
% �摜�t�@�C���̑I��
uiwait(msgbox('�f�[�^�̖��ߍ��܂ꂽ�摜��I�����Ă��������B'));
[FileName, PathName, FilterIndex] = uigetfile({'*.png;*.bmp;*.gif;*.jpg;*.jpeg', '�摜�t�@�C��(*.bmp,*.png,*.gif,*.jpg,*.jpeg)'}, '���ߍ��݉摜�I��');
if FilterIndex == 0
    disp('�t�@�C��������܂���B');
    uiwait(msgbox('�t�@�C�������݂��܂���B', '', 'error'));
    return;
else

% �摜�ǂݍ���
ImgPath = fullfile(PathName, FileName);
img = imread(ImgPath);
% imshow(img);

% �f�[�^���o
% RGB�e�X�̉���2bits�𒊏o����
bytes = uint8([]);
k = 1;
seekbar = waitbar(0, '���o��...');
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

% ���o�f�[�^�̕ۑ���I��
uiwait(msgbox('���o�f�[�^�̕ۑ����I�����Ă��������B'));
[FileName, PathName, FilterIndex] = uiputfile({'*.*', '�t�@�C��(*.*)'}, '�f�[�^�ۑ���I��');
if FilterIndex == 0
    disp('�t�@�C�����I������Ă��܂���B');
    uiwait(msgbox('�t�@�C�����I������Ă��܂���B', '', 'error'));
    return;
else

% ���o�f�[�^�̏o��
bytes = transpose(bytes);
FilePath = fullfile(PathName, FileName);
fileID = fopen(FilePath, 'w');
bytes = fwrite(fileID, bytes, 'uint8');
fclose(fileID);

% �t�@�C���o��
disp('�t�@�C�����o�͂��܂����B');
disp(FilePath);
uiwait(msgbox(['�t�@�C�����o�͂��܂����B', 10, FilePath]));

end;
end;
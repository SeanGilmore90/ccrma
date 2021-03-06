% test_onsets("simpleLoop.wav");
% test_onsets("jw_prelude3.wav")
function marked_onset_times = test_onsets(inputSoundPath)
%
  [audio_signal, sample_rate, resolution] = wavread(tilde_expand(inputSoundPath));
  num_audio_channels = size(audio_signal, 2); % determine from signal.
  mono_audio_signal = sum(audio_signal, 2) / num_audio_channels;

  [marked_onset_times, attack_times] = onset_times(mono_audio_signal, sample_rate);

  figure()
  % plot(mono_audio_signal, '1')
  % plot(mono_audio_signal, '1', marked_onset_times .* sample_rate, ones(1,length(marked_onset_times)), '2^')
  plot(1:length(mono_audio_signal), mono_audio_signal, '-', marked_onset_times .* sample_rate, ones(1,length(marked_onset_times)), '^')

  
  beep = sinetone(880, sample_rate, 0.050, 0.8);
  % wavwrite(beep, sample_rate, '/tmp/beep.wav');
  [dir, filename, ext] = fileparts(inputSoundPath);
  fileToSave = fullfile(dir, [filename, '_onsets.wav']);
  save_rhythm_mix(fileToSave, inputSoundPath, marked_onset_times, beep);
end

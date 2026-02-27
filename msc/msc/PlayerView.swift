//
//  PlayerView.swift
//  msc
//
//  Created by nieyrinn on 07.03.2026.
//


import SwiftUI

struct PlayerView: View {
    @State var viewModel: PlayerViewModel

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                AsyncImage(url: URL(string: viewModel.track.artworkUrl600)) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().scaledToFit()
                    default:
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                            .aspectRatio(1, contentMode: .fit)
                            .overlay(Image(systemName: "music.note")
                                .font(.system(size: 60))
                                .foregroundStyle(.gray))
                    }
                }
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.3), radius: 20, y: 10)
                .scaleEffect(viewModel.isPlaying ? 1.0 : 0.92)
                .animation(.spring(response: 0.4), value: viewModel.isPlaying)

                Spacer().frame(height: 40)

                VStack(spacing: 6) {
                    Text(viewModel.track.trackName)
                        .font(.title2.bold())
                        .multilineTextAlignment(.center)
                    Text(viewModel.track.artistName)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 32)

                Spacer().frame(height: 32)

                ProgressView(value: 0.0)
                    .padding(.horizontal, 32)

                HStack {
                    Text("0:00")
                    Spacer()
                    Text(viewModel.track.durationFormatted)
                }
                .font(.caption.monospacedDigit())
                .foregroundStyle(.secondary)
                .padding(.horizontal, 34)
                .padding(.top, 6)

                Spacer().frame(height: 32)

                HStack(spacing: 48) {
                    Button { } label: {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }

                    Button {
                        viewModel.togglePlayback()
                    } label: {
                        Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 70))
                            .foregroundStyle(.primary)
                    }

                    Button { } label: {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                }

                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
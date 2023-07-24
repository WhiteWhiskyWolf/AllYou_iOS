//
//  ChatView.swift
//  AllYou
//
//  Created by Cate Daniel on 2023-05-16.
//

import SwiftUI

struct ThreadsView: View {
    @ObservedObject var store: Store<ThreadsViewState, ThreadsViewActions> = Store(
        initialAction: .LoadThreads,
        initialState: ThreadsViewState.Loading,
        reducer: ThreadsViewReducer().reducer,
        sideEffects: ThreadsViewSideEffects().sideEffects()
    )
    
    var body: some View {
        ThreadsView_Internal(
            state: store.state,
            dispatch: store.dispatch
        )
        .frame(maxHeight: .infinity)
    }
}

private struct ThreadsView_Internal: View {
    let state: ThreadsViewState
    let dispatch: Dispatch<ThreadsViewActions>
    var body: some View {
        VStack {
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Messages")
                        .font(.title)
                        .foregroundColor(Color.onPrimary)
                    
                    Spacer()
                    
                    Button(
                        action: {dispatch(ThreadsViewActions.DisplayNewThread)},
                        label: {Image(systemName: "plus.message.fill")}
                    )
                    .buttonStyle(SecondaryButtonSmall())
                    .accessibilityElement()
                    .accessibilityLabel("New Message")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.primaryColor)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
        
            Spacer()
                .oneVertical()
            
            switch(state) {
            case .Loading:
                LoadingThreadsView()
            case .Loaded(
                displayNewThreads: let displayThreads,
                threads: let threads
            ):
                LoadedThreadsview(
                    displayNewThreads: displayThreads,
                    threads: threads,
                    dispatch: dispatch)
            }
            
            Spacer()
        }
        .padding()
    }
}

private struct LoadedThreadsview: View {
    let displayNewThreads: Bool
    let threads: [ThreadUIModel]
    let dispatch: Dispatch<ThreadsViewActions>
    
    var body: some View {
        let newThreadsBinding = Binding(
            get: {displayNewThreads},
            set: {
                if ($0) {
                    dispatch(ThreadsViewActions.DisplayNewThread)
                } else {
                    dispatch(ThreadsViewActions.HideNewThread)
                }
            }
        )
        LazyVStack {
            Text("Test")
        }
        .popover(
            isPresented: newThreadsBinding,
            content: {NewThreadView()}
        )
    }
}

private struct LoadingThreadsView: View {
    var body: some View {
        ProgressView()
    }
}

struct ChatView_Loading_Previews: PreviewProvider {
    static var previews: some View {
        ThreadsView_Internal(
            state: ThreadsViewState.Loading,
            dispatch: {_ in }
        )
    }
}

struct ChatView_Loaded_Previews: PreviewProvider {
    static var previews: some View {
        ThreadsView_Internal(
            state: ThreadsViewState.Loaded(
                displayNewThreads: false,
                threads: []
            ),
            dispatch: {_ in }
        )
    }
}


struct ChatView_NewThread_Previews: PreviewProvider {
    static var previews: some View {
        ThreadsView_Internal(
            state: ThreadsViewState.Loaded(
                displayNewThreads: true,
                threads: []
            ),
            dispatch: {_ in }
        )
    }
}

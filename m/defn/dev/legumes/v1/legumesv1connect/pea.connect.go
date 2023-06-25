// Code generated by protoc-gen-connect-go. DO NOT EDIT.
//
// Source: legumes/v1/pea.proto

// $schema: defn.dev.legumes.v1.Pea
// $title: Cool pea
// $description: So many cool peas
// $location: https://defn.dev/legumes/pea/v1

// cool
package legumesv1connect

import (
	context "context"
	errors "errors"
	connect_go "github.com/bufbuild/connect-go"
	v1 "github.com/defn/dev/m/defn/dev/legumes/v1"
	http "net/http"
	strings "strings"
)

// This is a compile-time assertion to ensure that this generated file and the connect package are
// compatible. If you get a compiler error that this constant is not defined, this code was
// generated with a version of connect newer than the one compiled into your binary. You can fix the
// problem by either regenerating this code with an older version of connect or updating the connect
// version compiled into your binary.
const _ = connect_go.IsAtLeastVersion0_1_0

const (
	// PeaStoreServiceName is the fully-qualified name of the PeaStoreService service.
	PeaStoreServiceName = "defn.dev.legumes.v1.PeaStoreService"
)

// These constants are the fully-qualified names of the RPCs defined in this package. They're
// exposed at runtime as Spec.Procedure and as the final two segments of the HTTP route.
//
// Note that these are different from the fully-qualified method names used by
// google.golang.org/protobuf/reflect/protoreflect. To convert from these constants to
// reflection-formatted method names, remove the leading slash and convert the remaining slash to a
// period.
const (
	// PeaStoreServiceGetPeaProcedure is the fully-qualified name of the PeaStoreService's GetPea RPC.
	PeaStoreServiceGetPeaProcedure = "/defn.dev.legumes.v1.PeaStoreService/GetPea"
	// PeaStoreServicePutPeaProcedure is the fully-qualified name of the PeaStoreService's PutPea RPC.
	PeaStoreServicePutPeaProcedure = "/defn.dev.legumes.v1.PeaStoreService/PutPea"
	// PeaStoreServiceDeletePeaProcedure is the fully-qualified name of the PeaStoreService's DeletePea
	// RPC.
	PeaStoreServiceDeletePeaProcedure = "/defn.dev.legumes.v1.PeaStoreService/DeletePea"
)

// PeaStoreServiceClient is a client for the defn.dev.legumes.v1.PeaStoreService service.
type PeaStoreServiceClient interface {
	// get the peas
	GetPea(context.Context, *connect_go.Request[v1.GetPeaRequest]) (*connect_go.Response[v1.GetPeaResponse], error)
	// put the peas
	PutPea(context.Context, *connect_go.Request[v1.PutPeaRequest]) (*connect_go.Response[v1.PutPeaResponse], error)
	// del the peas
	DeletePea(context.Context, *connect_go.Request[v1.DeletePeaRequest]) (*connect_go.Response[v1.DeletePeaResponse], error)
}

// NewPeaStoreServiceClient constructs a client for the defn.dev.legumes.v1.PeaStoreService service.
// By default, it uses the Connect protocol with the binary Protobuf Codec, asks for gzipped
// responses, and sends uncompressed requests. To use the gRPC or gRPC-Web protocols, supply the
// connect.WithGRPC() or connect.WithGRPCWeb() options.
//
// The URL supplied here should be the base URL for the Connect or gRPC server (for example,
// http://api.acme.com or https://acme.com/grpc).
func NewPeaStoreServiceClient(httpClient connect_go.HTTPClient, baseURL string, opts ...connect_go.ClientOption) PeaStoreServiceClient {
	baseURL = strings.TrimRight(baseURL, "/")
	return &peaStoreServiceClient{
		getPea: connect_go.NewClient[v1.GetPeaRequest, v1.GetPeaResponse](
			httpClient,
			baseURL+PeaStoreServiceGetPeaProcedure,
			opts...,
		),
		putPea: connect_go.NewClient[v1.PutPeaRequest, v1.PutPeaResponse](
			httpClient,
			baseURL+PeaStoreServicePutPeaProcedure,
			opts...,
		),
		deletePea: connect_go.NewClient[v1.DeletePeaRequest, v1.DeletePeaResponse](
			httpClient,
			baseURL+PeaStoreServiceDeletePeaProcedure,
			opts...,
		),
	}
}

// peaStoreServiceClient implements PeaStoreServiceClient.
type peaStoreServiceClient struct {
	getPea    *connect_go.Client[v1.GetPeaRequest, v1.GetPeaResponse]
	putPea    *connect_go.Client[v1.PutPeaRequest, v1.PutPeaResponse]
	deletePea *connect_go.Client[v1.DeletePeaRequest, v1.DeletePeaResponse]
}

// GetPea calls defn.dev.legumes.v1.PeaStoreService.GetPea.
func (c *peaStoreServiceClient) GetPea(ctx context.Context, req *connect_go.Request[v1.GetPeaRequest]) (*connect_go.Response[v1.GetPeaResponse], error) {
	return c.getPea.CallUnary(ctx, req)
}

// PutPea calls defn.dev.legumes.v1.PeaStoreService.PutPea.
func (c *peaStoreServiceClient) PutPea(ctx context.Context, req *connect_go.Request[v1.PutPeaRequest]) (*connect_go.Response[v1.PutPeaResponse], error) {
	return c.putPea.CallUnary(ctx, req)
}

// DeletePea calls defn.dev.legumes.v1.PeaStoreService.DeletePea.
func (c *peaStoreServiceClient) DeletePea(ctx context.Context, req *connect_go.Request[v1.DeletePeaRequest]) (*connect_go.Response[v1.DeletePeaResponse], error) {
	return c.deletePea.CallUnary(ctx, req)
}

// PeaStoreServiceHandler is an implementation of the defn.dev.legumes.v1.PeaStoreService service.
type PeaStoreServiceHandler interface {
	// get the peas
	GetPea(context.Context, *connect_go.Request[v1.GetPeaRequest]) (*connect_go.Response[v1.GetPeaResponse], error)
	// put the peas
	PutPea(context.Context, *connect_go.Request[v1.PutPeaRequest]) (*connect_go.Response[v1.PutPeaResponse], error)
	// del the peas
	DeletePea(context.Context, *connect_go.Request[v1.DeletePeaRequest]) (*connect_go.Response[v1.DeletePeaResponse], error)
}

// NewPeaStoreServiceHandler builds an HTTP handler from the service implementation. It returns the
// path on which to mount the handler and the handler itself.
//
// By default, handlers support the Connect, gRPC, and gRPC-Web protocols with the binary Protobuf
// and JSON codecs. They also support gzip compression.
func NewPeaStoreServiceHandler(svc PeaStoreServiceHandler, opts ...connect_go.HandlerOption) (string, http.Handler) {
	mux := http.NewServeMux()
	mux.Handle(PeaStoreServiceGetPeaProcedure, connect_go.NewUnaryHandler(
		PeaStoreServiceGetPeaProcedure,
		svc.GetPea,
		opts...,
	))
	mux.Handle(PeaStoreServicePutPeaProcedure, connect_go.NewUnaryHandler(
		PeaStoreServicePutPeaProcedure,
		svc.PutPea,
		opts...,
	))
	mux.Handle(PeaStoreServiceDeletePeaProcedure, connect_go.NewUnaryHandler(
		PeaStoreServiceDeletePeaProcedure,
		svc.DeletePea,
		opts...,
	))
	return "/defn.dev.legumes.v1.PeaStoreService/", mux
}

// UnimplementedPeaStoreServiceHandler returns CodeUnimplemented from all methods.
type UnimplementedPeaStoreServiceHandler struct{}

func (UnimplementedPeaStoreServiceHandler) GetPea(context.Context, *connect_go.Request[v1.GetPeaRequest]) (*connect_go.Response[v1.GetPeaResponse], error) {
	return nil, connect_go.NewError(connect_go.CodeUnimplemented, errors.New("defn.dev.legumes.v1.PeaStoreService.GetPea is not implemented"))
}

func (UnimplementedPeaStoreServiceHandler) PutPea(context.Context, *connect_go.Request[v1.PutPeaRequest]) (*connect_go.Response[v1.PutPeaResponse], error) {
	return nil, connect_go.NewError(connect_go.CodeUnimplemented, errors.New("defn.dev.legumes.v1.PeaStoreService.PutPea is not implemented"))
}

func (UnimplementedPeaStoreServiceHandler) DeletePea(context.Context, *connect_go.Request[v1.DeletePeaRequest]) (*connect_go.Response[v1.DeletePeaResponse], error) {
	return nil, connect_go.NewError(connect_go.CodeUnimplemented, errors.New("defn.dev.legumes.v1.PeaStoreService.DeletePea is not implemented"))
}

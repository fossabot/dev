// Code generated by protoc-gen-connect-go. DO NOT EDIT.
//
// Source: legumes/v1/bean.proto

// $schema: defn.dev.legumes.v1.Bean
// $title: Cool bean
// $description: So many cool beans
// $location: https://defn.dev/legumes/bean/v1

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
	// BeanStoreServiceName is the fully-qualified name of the BeanStoreService service.
	BeanStoreServiceName = "defn.dev.legumes.v1.BeanStoreService"
)

// These constants are the fully-qualified names of the RPCs defined in this package. They're
// exposed at runtime as Spec.Procedure and as the final two segments of the HTTP route.
//
// Note that these are different from the fully-qualified method names used by
// google.golang.org/protobuf/reflect/protoreflect. To convert from these constants to
// reflection-formatted method names, remove the leading slash and convert the remaining slash to a
// period.
const (
	// BeanStoreServiceGetBeanProcedure is the fully-qualified name of the BeanStoreService's GetBean
	// RPC.
	BeanStoreServiceGetBeanProcedure = "/defn.dev.legumes.v1.BeanStoreService/GetBean"
	// BeanStoreServicePutBeanProcedure is the fully-qualified name of the BeanStoreService's PutBean
	// RPC.
	BeanStoreServicePutBeanProcedure = "/defn.dev.legumes.v1.BeanStoreService/PutBean"
	// BeanStoreServiceDeleteBeanProcedure is the fully-qualified name of the BeanStoreService's
	// DeleteBean RPC.
	BeanStoreServiceDeleteBeanProcedure = "/defn.dev.legumes.v1.BeanStoreService/DeleteBean"
)

// BeanStoreServiceClient is a client for the defn.dev.legumes.v1.BeanStoreService service.
type BeanStoreServiceClient interface {
	// get the beans
	GetBean(context.Context, *connect_go.Request[v1.GetBeanRequest]) (*connect_go.Response[v1.GetBeanResponse], error)
	// put the beans
	PutBean(context.Context, *connect_go.Request[v1.PutBeanRequest]) (*connect_go.Response[v1.PutBeanResponse], error)
	// del the beans
	DeleteBean(context.Context, *connect_go.Request[v1.DeleteBeanRequest]) (*connect_go.Response[v1.DeleteBeanResponse], error)
}

// NewBeanStoreServiceClient constructs a client for the defn.dev.legumes.v1.BeanStoreService
// service. By default, it uses the Connect protocol with the binary Protobuf Codec, asks for
// gzipped responses, and sends uncompressed requests. To use the gRPC or gRPC-Web protocols, supply
// the connect.WithGRPC() or connect.WithGRPCWeb() options.
//
// The URL supplied here should be the base URL for the Connect or gRPC server (for example,
// http://api.acme.com or https://acme.com/grpc).
func NewBeanStoreServiceClient(httpClient connect_go.HTTPClient, baseURL string, opts ...connect_go.ClientOption) BeanStoreServiceClient {
	baseURL = strings.TrimRight(baseURL, "/")
	return &beanStoreServiceClient{
		getBean: connect_go.NewClient[v1.GetBeanRequest, v1.GetBeanResponse](
			httpClient,
			baseURL+BeanStoreServiceGetBeanProcedure,
			opts...,
		),
		putBean: connect_go.NewClient[v1.PutBeanRequest, v1.PutBeanResponse](
			httpClient,
			baseURL+BeanStoreServicePutBeanProcedure,
			opts...,
		),
		deleteBean: connect_go.NewClient[v1.DeleteBeanRequest, v1.DeleteBeanResponse](
			httpClient,
			baseURL+BeanStoreServiceDeleteBeanProcedure,
			opts...,
		),
	}
}

// beanStoreServiceClient implements BeanStoreServiceClient.
type beanStoreServiceClient struct {
	getBean    *connect_go.Client[v1.GetBeanRequest, v1.GetBeanResponse]
	putBean    *connect_go.Client[v1.PutBeanRequest, v1.PutBeanResponse]
	deleteBean *connect_go.Client[v1.DeleteBeanRequest, v1.DeleteBeanResponse]
}

// GetBean calls defn.dev.legumes.v1.BeanStoreService.GetBean.
func (c *beanStoreServiceClient) GetBean(ctx context.Context, req *connect_go.Request[v1.GetBeanRequest]) (*connect_go.Response[v1.GetBeanResponse], error) {
	return c.getBean.CallUnary(ctx, req)
}

// PutBean calls defn.dev.legumes.v1.BeanStoreService.PutBean.
func (c *beanStoreServiceClient) PutBean(ctx context.Context, req *connect_go.Request[v1.PutBeanRequest]) (*connect_go.Response[v1.PutBeanResponse], error) {
	return c.putBean.CallUnary(ctx, req)
}

// DeleteBean calls defn.dev.legumes.v1.BeanStoreService.DeleteBean.
func (c *beanStoreServiceClient) DeleteBean(ctx context.Context, req *connect_go.Request[v1.DeleteBeanRequest]) (*connect_go.Response[v1.DeleteBeanResponse], error) {
	return c.deleteBean.CallUnary(ctx, req)
}

// BeanStoreServiceHandler is an implementation of the defn.dev.legumes.v1.BeanStoreService service.
type BeanStoreServiceHandler interface {
	// get the beans
	GetBean(context.Context, *connect_go.Request[v1.GetBeanRequest]) (*connect_go.Response[v1.GetBeanResponse], error)
	// put the beans
	PutBean(context.Context, *connect_go.Request[v1.PutBeanRequest]) (*connect_go.Response[v1.PutBeanResponse], error)
	// del the beans
	DeleteBean(context.Context, *connect_go.Request[v1.DeleteBeanRequest]) (*connect_go.Response[v1.DeleteBeanResponse], error)
}

// NewBeanStoreServiceHandler builds an HTTP handler from the service implementation. It returns the
// path on which to mount the handler and the handler itself.
//
// By default, handlers support the Connect, gRPC, and gRPC-Web protocols with the binary Protobuf
// and JSON codecs. They also support gzip compression.
func NewBeanStoreServiceHandler(svc BeanStoreServiceHandler, opts ...connect_go.HandlerOption) (string, http.Handler) {
	mux := http.NewServeMux()
	mux.Handle(BeanStoreServiceGetBeanProcedure, connect_go.NewUnaryHandler(
		BeanStoreServiceGetBeanProcedure,
		svc.GetBean,
		opts...,
	))
	mux.Handle(BeanStoreServicePutBeanProcedure, connect_go.NewUnaryHandler(
		BeanStoreServicePutBeanProcedure,
		svc.PutBean,
		opts...,
	))
	mux.Handle(BeanStoreServiceDeleteBeanProcedure, connect_go.NewUnaryHandler(
		BeanStoreServiceDeleteBeanProcedure,
		svc.DeleteBean,
		opts...,
	))
	return "/defn.dev.legumes.v1.BeanStoreService/", mux
}

// UnimplementedBeanStoreServiceHandler returns CodeUnimplemented from all methods.
type UnimplementedBeanStoreServiceHandler struct{}

func (UnimplementedBeanStoreServiceHandler) GetBean(context.Context, *connect_go.Request[v1.GetBeanRequest]) (*connect_go.Response[v1.GetBeanResponse], error) {
	return nil, connect_go.NewError(connect_go.CodeUnimplemented, errors.New("defn.dev.legumes.v1.BeanStoreService.GetBean is not implemented"))
}

func (UnimplementedBeanStoreServiceHandler) PutBean(context.Context, *connect_go.Request[v1.PutBeanRequest]) (*connect_go.Response[v1.PutBeanResponse], error) {
	return nil, connect_go.NewError(connect_go.CodeUnimplemented, errors.New("defn.dev.legumes.v1.BeanStoreService.PutBean is not implemented"))
}

func (UnimplementedBeanStoreServiceHandler) DeleteBean(context.Context, *connect_go.Request[v1.DeleteBeanRequest]) (*connect_go.Response[v1.DeleteBeanResponse], error) {
	return nil, connect_go.NewError(connect_go.CodeUnimplemented, errors.New("defn.dev.legumes.v1.BeanStoreService.DeleteBean is not implemented"))
}
